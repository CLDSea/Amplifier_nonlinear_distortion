module BUS
       (
           input clk, rst_n,
           input [11: 0]ADDR,
           input RD, WR,
           inout [15: 0]DATA,

           output cs0, cs1, cs2, cs3, cs4, cs5, cs6, cs7, cs8, cs9, cs10, cs11, cs12, cs13, cs14, cs15,
           input [15: 0]rddata0, rddata1, rddata2, rddata3, rddata4, rddata5, rddata6, rddata7, rddata8, rddata9, rddata10, rddata11, rddata12, rddata13, rddata14, rddata15,
           output reg [15: 0] wrdata0, wrdata1, wrdata2, wrdata3, wrdata4, wrdata5, wrdata6, wrdata7, wrdata8, wrdata9, wrdata10, wrdata11, wrdata12, wrdata13, wrdata14, wrdata15
       );

assign cs0 = (ADDR[11: 8] == 4'd0);
assign cs1 = (ADDR[11: 8] == 4'd1);
assign cs2 = (ADDR[11: 8] == 4'd2);
assign cs3 = (ADDR[11: 8] == 4'd3);
assign cs4 = (ADDR[11: 8] == 4'd4);
assign cs5 = (ADDR[11: 8] == 4'd5);
assign cs6 = (ADDR[11: 8] == 4'd6);
assign cs7 = (ADDR[11: 8] == 4'd7);
assign cs8 = (ADDR[11: 8] == 4'd8);
assign cs9 = (ADDR[11: 8] == 4'd9);
assign cs10 = (ADDR[11: 8] == 4'd10);
assign cs11 = (ADDR[11: 8] == 4'd11);
assign cs12 = (ADDR[11: 8] == 4'd12);
assign cs13 = (ADDR[11: 8] == 4'd13);
assign cs14 = (ADDR[11: 8] == 4'd14);
assign cs15 = (ADDR[11: 8] == 4'd15);

reg [15: 0]rdmux;
always @(posedge clk)
begin
    case (ADDR[11: 8])
        4'd0:
            rdmux <= rddata0;
        4'd1:
            rdmux <= rddata1;
        4'd2:
            rdmux <= rddata2;
        4'd3:
            rdmux <= rddata3;
        4'd4:
            rdmux <= rddata4;
        4'd5:
            rdmux <= rddata5;
        4'd6:
            rdmux <= rddata6;
        4'd7:
            rdmux <= rddata7;
        4'd8:
            rdmux <= rddata8;
        4'd9:
            rdmux <= rddata9;
        4'd10:
            rdmux <= rddata10;
        4'd11:
            rdmux <= rddata11;
        4'd12:
            rdmux <= rddata12;
        4'd13:
            rdmux <= rddata13;
        4'd14:
            rdmux <= rddata14;
        4'd15:
            rdmux <= rddata15;
        default:
            ;
    endcase
end

always @(posedge WR)
begin
    if (WR)
    begin
        case (ADDR[11: 8])
            4'd0:
                wrdata0 <= DATA;
            4'd1:
                wrdata1 <= DATA;
            4'd2:
                wrdata2 <= DATA;
            4'd3:
                wrdata3 <= DATA;
            4'd4:
                wrdata4 <= DATA;
            4'd5:
                wrdata5 <= DATA;
            4'd6:
                wrdata6 <= DATA;
            4'd7:
                wrdata7 <= DATA;
            4'd8:
                wrdata8 <= DATA;
            4'd9:
                wrdata9 <= DATA;
            4'd10:
                wrdata10 <= DATA;
            4'd11:
                wrdata11 <= DATA;
            4'd12:
                wrdata12 <= DATA;
            4'd13:
                wrdata13 <= DATA;
            4'd14:
                wrdata14 <= DATA;
            4'd15:
                wrdata15 <= DATA;
            default:
                ;
        endcase
    end
end
assign DATA = RD ? rdmux : 16'hzzzz;
endmodule