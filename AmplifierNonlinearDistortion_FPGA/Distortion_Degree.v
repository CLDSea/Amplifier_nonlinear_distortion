module Distortion_Degree
       (
           input clk,
           input rst_n,
           input source_sop,
           input source_eop,
           input [23: 0] source_data,

           output reg[11: 0]distortion_degree_numer,  //分子
           output reg[11: 0]distortion_degree_denom,  //分母
           output reg[23: 0]data0, data1, data2, data3, data4, data5, data6, data7
       );

reg [31: 0]count;

reg [23: 0]sum;
always@(posedge clk or negedge rst_n)
begin
    if (!rst_n)
    begin
        count <= 0;
        data0 <= 0;
        data1 <= 0;
        data2 <= 0;
        data3 <= 0;
        data4 <= 0;
        data5 <= 0;
        data6 <= 0;
        data7 <= 0;
    end
    else
    begin
        if (count != 0)
        begin
            count <= count + 1;
        end
        if (source_sop)
        begin
            count <= 1;
            data0 <= source_data;
        end
        case (count)
            1:
            begin
                data1 <= source_data;
            end
            2:
            begin
                data2 <= source_data;
            end
            3:
            begin
                data3 <= source_data;
            end
            4:
            begin
                data4 <= source_data;
            end
            5:
            begin
                data5 <= source_data;
            end
            6:
            begin
                data6 <= source_data;
            end
            7:
            begin
                data7 <= source_data;
            end
            8:
            begin
                sum <= data2 + data3 + data4 + data5;
                count <= 0;
            end
            default:
            begin
            end
        endcase
    end
end

wire[11: 0]q;
wire[11: 0]q1;
wire[12: 0]remainder;
wire[12: 0]remainder1;

SQRT	SQRT_inst
     (
         .clk ( clk ),
         .radical (sum),
         .q ( q ),    //分子
         .remainder (remainder)
     );
SQRT	SQRT_inst2
     (
         .clk ( clk ),
         .radical (data1),
         .q (q1 ),    //分母
         .remainder (remainder1)
     );

always@(posedge clk or negedge rst_n)
begin
    if (!rst_n)
    begin
        distortion_degree_numer <= 0;
        distortion_degree_denom <= 0;
    end
    else
    begin
        if (remainder > q)
        begin
            distortion_degree_numer <= q + 1;
        end
        else
        begin
            distortion_degree_numer <= q;
        end
        if (remainder1 > q1)
        begin
            distortion_degree_denom <= q1 + 1;
        end
        else
        begin
            distortion_degree_denom <= q1;
        end
    end
end
endmodule