module edge_bit (
input wire enable ,clk,rst,
output reg [3:0] bit_cnt ,
output reg [2:0] edge_cnt
);

always @(posedge clk ,negedge rst) 
begin
    if (!rst,!enable)       //reset is the gignal come from fsm (hassona)
        begin
            edge_cnt<=3'b000;
        end
    else if (enable)
        begin
            edge_cnt<=edge_cnt+3'b001;

        end 
end
always @(posedge clk,negedge rst) 
begin
    if (!rst)
        bit_cnt <= 4'b0000;
        
    else if (& edge_cnt) begin
         bit_cnt<=bit_cnt+4'b0001; end

    else if (bit_cnt == 4'b1011) begin
            bit_cnt <= 4'b0000;    end
end
endmodule