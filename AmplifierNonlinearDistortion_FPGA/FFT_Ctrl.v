module FFT_Ctrl
       (
           input clk,
           input rst_n,
           input [11: 0]data_in,
           input [31: 0]fft_cnt_flag,
           input [31: 0]fft_delay_flag,

           output source_sop_delay,
           output source_eop_delay,
           output reg[23: 0] source_data //延迟2个周期
       );

reg sink_real;
wire [11: 0]source_real;
wire [11: 0]source_imag;

reg sink_valid;
wire sink_sop = (fft_cnt == 1) ? sink_valid : 0; //生成sop信号
wire sink_eop = (fft_cnt == fft_cnt_flag) ? sink_valid : 0; //生成eop信号


reg fft_state;
reg [31: 0]fft_cnt;
reg [31: 0]fft_delay;
always @ (posedge clk or negedge rst_n)
begin
    if (!rst_n)
    begin
        sink_valid <= 0;
        fft_cnt <= 0;
        fft_state <= 0;
        fft_delay <= 0;
    end
    else
    begin
        case (fft_state)
            0:
            begin
                if (fft_cnt < fft_cnt_flag)		//计数输入长度
                begin
                    sink_valid <= 1;
                    fft_cnt <= fft_cnt + 1;
                end
                else
                begin

                    fft_cnt <= 0;
                    fft_state <= 1;
                end
            end
            1:
            begin
                sink_valid <= 0;
                if (fft_delay < fft_delay_flag)		//一个粗略的延时，等待fft ip核计算和输出完成，根据fft长度要改变相应延时值
                begin
                    fft_delay <= fft_delay + 1;
                end
                else
                begin
                    fft_delay <= 0;
                    fft_state <= 0;
                end
            end
            default:
            begin
            end
        endcase
    end
end

FFT FFT_inst
    (
        .clk(clk) ,  	// input  clk_sig
        .reset_n(rst_n) ,  	// input  reset_n_sig
        .inverse(0) ,  	// input  inverse_sig
        .sink_valid(sink_valid) ,  	// input  sink_valid_sig
        .sink_sop(sink_sop) ,  	// input  sink_sop_sig
        .sink_eop(sink_eop) ,  	// input  sink_eop_sig
        .sink_real(data_in) ,  	// input [11:0] sink_real_sig
        .sink_imag(0) ,  	// input [11:0] sink_imag_sig
        .sink_error(0) ,  	// input [1:0] sink_error_sig
        .source_ready(1) ,  	// input  source_ready_sig
        .sink_ready() ,  	// output  sink_ready_sig
        .source_error() ,  	// output [1:0] source_error_sig
        .source_sop(source_sop) ,  	// output  source_sop_sig
        .source_eop(source_eop) ,  	// output  source_eop_sig
        .source_valid() ,  	// output  source_valid_sig
        .source_exp() ,  	// output [5:0] source_exp_sig
        .source_real(source_real) ,  	// output [11:0] source_real_sig
        .source_imag(source_imag) 	// output [11:0] source_imag_sig
    );

reg [11: 0] data_real;
reg [11: 0] data_imag;

//取实部和虚部的平方和
always @ (posedge clk or negedge rst_n)
begin
    if (!rst_n)
    begin
        source_data <= 0;
        data_real <= 0;
        data_imag <= 0;
    end
    else
    begin
        if (source_real[11] == 0)               //由补码计算原码
        begin
            data_real <= source_real;
        end
        else
        begin
            data_real <= ~source_real + 1;
        end

        if (source_imag[11] == 0)               //由补码计算原码
        begin
            data_imag <= source_imag;
        end
        else
        begin
            data_imag <= ~source_imag + 1;
        end
        //计算原码平方和
        source_data <= (data_real * data_real) + (data_imag * data_imag);
    end
end

reg source_sop_delay1;
reg source_sop_delay2;
reg source_eop_delay1;
reg source_eop_delay2;

assign source_sop_delay = source_sop_delay2;
assign source_eop_delay = source_eop_delay2;

always@(posedge clk or negedge rst_n) //延迟三个周期
begin
    if (!rst_n)
    begin
        source_sop_delay1 <= 0;
        source_sop_delay2 <= 0;
        source_eop_delay1 <= 0;
        source_eop_delay2 <= 0;
    end
    else
    begin
        source_sop_delay1 <= source_sop;
        source_sop_delay2 <= source_sop_delay1;
        source_eop_delay1 <= source_eop;
        source_eop_delay2 <= source_eop_delay1;
    end
end

endmodule