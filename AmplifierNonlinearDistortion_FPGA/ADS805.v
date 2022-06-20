module ADS805
       (
           input clk,
           input rst_n,
           input [11: 0]data_in,
           output reg[11: 0]data_in_real
       );

reg [11: 0]data_in_reg;
always@(negedge clk or negedge rst_n)
begin
    if (!rst_n)
    begin
        data_in_reg <= 0;
    end
    else
    begin
        data_in_reg <= data_in;
    end
end

always@(posedge clk or negedge rst_n)
begin
    if (!rst_n)
    begin
        data_in_real <= 0;
    end
    else
    begin
        data_in_real <= data_in_reg;
    end
end

endmodule