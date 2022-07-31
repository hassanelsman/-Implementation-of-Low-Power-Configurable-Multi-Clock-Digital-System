//module name and ports declarations
module Logic_Unit #(parameter Width = 16)  (

input wire [1:0]		alu_fun,
input wire 				CLK,
input wire 				logic_enable,
input wire [Width-1:0]	A,B,
output reg 				logic_flag,
output reg [Width-1:0]	logic_out	);

// internal signals definition
reg					logic_flag_comb;
reg [Width - 1: 0]	logic_out_comb;


//RTL Code
always @ (*)
begin
 if (logic_enable)
  begin
   logic_flag_comb = 1'b1 ;
   case(alu_fun)
    
//	logic_out_comb = 'b0 ;
	
	2'b00 :	logic_out_comb = A & B;
	2'b01 : logic_out_comb = A | B;
	2'b10 : logic_out_comb = ~(A & B);
	2'b11 :	logic_out_comb = ~(A | B);
	default : logic_out_comb = 'b0;
	
   endcase
   
  end

 else
  begin
   logic_out_comb = 'b0;
   logic_flag_comb = 1'b0 ;
  end
  
end  

//sequential logic
always @(posedge CLK)
begin
 logic_flag <= logic_flag_comb;
 logic_out  <= logic_out_comb;
end 

endmodule
