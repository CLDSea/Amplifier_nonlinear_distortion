module CLK_Div
       (
           input clk,
           input rst_n,
           input [31: 0]someNum,

           output reg clk_out
       );

//占空比无要求
//freOut=freIn/someNum
reg[31: 0]count;
always@(posedge clk or negedge rst_n)
begin
    if (!rst_n)
    begin
        count <= 0;
        clk_out <= 0;
    end
    else
    begin
        if (count < someNum - 1) //count=0,1,2,...,someNum-1
        begin
            count <= count + 1;
        end
        if (count == someNum - 1)
        begin
            count <= 0;
            clk_out <= 1;
        end
        else if (count == ((someNum - 1) >> 1))
        begin
            clk_out <= 0;
        end
    end
end

endmodule