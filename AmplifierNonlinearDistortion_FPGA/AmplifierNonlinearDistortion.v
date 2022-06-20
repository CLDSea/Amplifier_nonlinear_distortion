module AmplifierNonlinearDistortion
       (
           input clk_50M,
           input rst_n,
           input [11: 0]ADDR,
           input RD, WR,
           inout [15: 0]DATA,

           inout [3: 0]KEY_H, KEY_V,

           input [11: 0]data_in,
           output clk_64K,
           output [3: 0]switch,
           output VCC
       ) ;

assign VCC = 1;

wire cs0, cs1, cs2, cs3, cs4, cs5, cs6, cs7, cs8, cs9, cs10, cs11, cs12, cs13, cs14, cs15;
wire [15: 0] rddata0, rddata1, rddata2, rddata3, rddata4, rddata5, rddata6, rddata7, rddata8, rddata9, rddata10, rddata11, rddata12, rddata13, rddata14, rddata15;
wire [15: 0] wrdata0, wrdata1, wrdata2, wrdata3, wrdata4, wrdata5, wrdata6, wrdata7, wrdata8, wrdata9, wrdata10, wrdata11, wrdata12, wrdata13, wrdata14, wrdata15;

BUS BUS_inst
    (
        .clk(clk_50M) ,   	// input  clk_sig
        .rst_n(rst_n) ,   	// input  rst_n_sig
        .ADDR(ADDR) ,   	// input [11:0] ADDR_sig
        .RD(RD) ,   	// input  RD_sig
        .WR(WR) ,   	// input  WR_sig
        .DATA(DATA) ,   	// inout [15:0] DATA_sig

        .cs0(cs0) ,   	// output  cs0_sig
        .cs1(cs1) ,   	// output  cs1_sig
        .cs2(cs2) ,   	// output  cs2_sig
        .cs3(cs3) ,   	// output  cs3_sig
        .cs4(cs4) ,   	// output  cs4_sig
        .cs5(cs5) ,   	// output  cs5_sig
        .cs6(cs6) ,   	// output  cs6_sig
        .cs7(cs7) ,   	// output  cs7_sig
        .cs8(cs8) ,   	// output  cs8_sig
        .cs9(cs9) ,   	// output  cs9_sig
        .cs10(cs10) ,   	// output  cs10_sig
        .cs11(cs11) ,   	// output  cs11_sig
        .cs12(cs12) ,   	// output  cs12_sig
        .cs13(cs13) ,   	// output  cs13_sig
        .cs14(cs14) ,   	// output  cs14_sig
        .cs15(cs15) ,   	// output  cs15_sig

        .rddata0(rddata0) ,   	// input [15:0] rddata0_sig
        .rddata1(rddata1) ,   	// input [15:0] rddata1_sig
        .rddata2(rddata2) ,   	// input [15:0] rddata2_sig
        .rddata3(rddata3) ,   	// input [15:0] rddata3_sig
        .rddata4(rddata4) ,   	// input [15:0] rddata4_sig
        .rddata5(rddata5) ,   	// input [15:0] rddata5_sig
        .rddata6(rddata6) ,   	// input [15:0] rddata6_sig
        .rddata7(rddata7) ,   	// input [15:0] rddata7_sig
        .rddata8(rddata8) ,   	// input [15:0] rddata8_sig
        .rddata9(rddata9) ,   	// input [15:0] rddata9_sig
        .rddata10(rddata10) ,   	// input [15:0] rddata10_sig
        .rddata11(rddata11) ,   	// input [15:0] rddata11_sig
        .rddata12(rddata12) ,   	// input [15:0] rddata12_sig
        .rddata13(rddata13) ,   	// input [15:0] rddata13_sig
        .rddata14(rddata14) ,   	// input [15:0] rddata14_sig
        .rddata15(rddata15) ,   	// input [15:0] rddata15_sig

        .wrdata0(wrdata0) ,   	// output [15:0] wrdata0_sig
        .wrdata1(wrdata1) ,   	// output [15:0] wrdata1_sig
        .wrdata2(wrdata2) ,   	// output [15:0] wrdata2_sig
        .wrdata3(wrdata3) ,    // output [15:0] wrdata3_sig
        .wrdata4(wrdata4) ,   	// output [15:0] wrdata4_sig
        .wrdata5(wrdata5) ,   	// output [15:0] wrdata5_sig
        .wrdata6(wrdata6) ,   	// output [15:0] wrdata6_sig
        .wrdata7(wrdata7) ,    // output [15:0] wrdata7_sig
        .wrdata8(wrdata8) ,   	// output [15:0] wrdata8_sig
        .wrdata9(wrdata9) ,   	// output [15:0] wrdata9_sig
        .wrdata10(wrdata10) ,   	// output [15:0] wrdata10_sig
        .wrdata11(wrdata11) , 	   // output [15:0] wrdata11_sig
        .wrdata12(wrdata12) ,   	// output [15:0] wrdata12_sig
        .wrdata13(wrdata13) ,   	// output [15:0] wrdata13_sig
        .wrdata14(wrdata14) ,   	// output [15:0] wrdata14_sig
        .wrdata15(wrdata15) 	   // output [15:0] wrdata15_sig
    );

KEY KEY_inst
    (
        .clk(clk_50M) ,   	// input  clk_sig
        .rst_n(rst_n) ,   	// input  rst_n_sig
        .rddata(rddata0) ,   	// output [15:0] rddata_sig
        .irq() ,   	// output  irq_sig
        .cs(cs0) ,   	// input  cs_sig
        .KEY_H(KEY_H) ,   	// inout [3:0] KEY_H_sig
        .KEY_V(KEY_V) 	// inout [3:0] KEY_V_sig
    );

assign rddata1 = cs1 ? {4'b0, distortion_degree_numer} : 0; //分子
assign rddata2 = cs2 ? {4'b0, distortion_degree_denom} : 0; //分母
assign switch = cs3 ? wrdata3[3 : 0] : switch;
assign rddata4 = cs4 ? data0 >> 8 : 0;
assign rddata5 = cs5 ? data1 >> 8 : 0;
assign rddata6 = cs6 ? data2 >> 8 : 0;
assign rddata7 = cs7 ? data3 >> 8 : 0;
assign rddata8 = cs8 ? data4 >> 8 : 0;
assign rddata9 = cs9 ? data5 >> 8 : 0;
assign rddata10 = cs10 ? data6 >> 8 : 0;
assign rddata11 = cs11 ? data7 >> 8 : 0;

////占空比无要求方波用于测试FFT
////fre=50M/(someNum+1)
//reg[31: 0]count;
//reg [11: 0]squareWave;
//always@(posedge clk_50M or negedge rst_n)
//begin
//    if (!rst_n)
//    begin
//        count <= 0;
//        squareWave <= 0;
//    end
//    else
//    begin
//        if (count < 49999) //count=0,1,2,...,49999
//        begin
//            count <= count + 1;
//        end
//        if (count == 49999)
//        begin
//            count <= 0;
//            squareWave <= 4095;
//        end
//        else if (count == (49999 >> 1))
//        begin
//            squareWave <= 0;
//        end
//    end
//end

wire clk_32M;
PLL	PLL_inst
    (
        .inclk0 ( clk_50M),
        .c0 ( clk_32M )
    );
CLK_Div CLK_Div_inst
        (
            .clk(clk_32M) ,  	// input  clk_sig
            .rst_n(rst_n) ,  	// input  rst_n_sig
            .someNum(500) ,  	// input [31:0] someNum_sig
            .clk_out(clk_64K) 	// output  clk_out_sig
        );

wire [11: 0]data_in_real;
//ADS805时序模块
ADS805 ADS805_inst
       (
           .clk(clk_64K) ,  	// input  clk_sig
           .rst_n(rst_n) ,  	// input  rst_n_sig
           .data_in(data_in) ,  	// input [11:0] data_in_sig
           .data_in_real(data_in_real) 	// output [11:0] data_in_real_sig
       );

wire source_sop;
wire source_eop;
wire [23: 0]source_data;
//FFT控制模块
FFT_Ctrl FFT_Ctrl_inst
         (
             .clk(clk_64K) ,  	// input  clk_sig
             .rst_n(rst_n) ,  	// input  rst_n_sig
             .data_in(data_in_real - 2048) ,  	// input [11:0] data_in_sig
             .fft_cnt_flag(64) ,  	// input [31:0] fft_cnt_flag_sig
             .fft_delay_flag(96) ,  	// input [31:0] fft_delay_flag_sig
             .source_sop_delay(source_sop) ,  	// output  source_sop_delay_sig
             .source_eop_delay(source_eop) ,  	// output  source_eop_delay_sig
             .source_data(source_data) 	// output [23:0] source_data_sig
         );
wire [11: 0]distortion_degree_numer;
wire [11: 0]distortion_degree_denom;

wire [23: 0]data0;
wire [23: 0]data1;
wire [23: 0]data2;
wire [23: 0]data3;
wire [23: 0]data4;
wire [23: 0]data5;
wire [23: 0]data6;
wire [23: 0]data7;

//总谐波失真度分子分母运算
Distortion_Degree Distortion_Degree_inst
                  (
                      .clk(clk_64K) ,  	// input  clk_sig
                      .rst_n(rst_n) ,  	// input  rst_n_sig
                      .source_sop(source_sop) ,  	// input  source_sop_sig
                      .source_eop(source_eop) ,  	// input  source_eop_sig
                      .source_data(source_data) ,  	// input [23:0] source_data_sig
                      .distortion_degree_numer(distortion_degree_numer) , 	// output [11:0] distortion_degree_numer_sig
                      .distortion_degree_denom(distortion_degree_denom) , 	// output [11:0] distortion_degree_denom_sig
                      .data0(data0) , 	// output [23:0] data0_sig
                      .data1(data1) , 	// output [23:0] data1_sig
                      .data2(data2) , 	// output [23:0] data2_sig
                      .data3(data3) , 	// output [23:0] data3_sig
                      .data4(data4) , 	// output [23:0] data4_sig
                      .data5(data5) , 	// output [23:0] data5_sig
                      .data6(data6) , 	// output [23:0] data6_sig
                      .data7(data7) 	// output [23:0] data7_sig
                  );

endmodule