//module name and ports declarations
module ALU_TOP (
input wire  [3:0]		ALU_FUN,
input wire 				CLK,
input wire  [15:0]		A,B,
output wire [15:0]		Arith_OUT,
output wire 			Carry_OUT,
output wire 			Arith_Flag,
output wire [15:0]		Logic_OUT,
output wire 			Logic_Flag,
output wire [15:0]		CMP_OUT,
output wire				CMP_Flag,
output wire [15:0]		Shift_OUT,
output wire 			Shift_Flag	);

// internal signals definition
wire 	Arith_Enable,Logic_Enable,CMP_Enable,Shift_Enable ;


// Units instatiation

Decoder_Unit Decoder (

.alu_fun(ALU_FUN [3:2]),
.arith_enable(Arith_Enable),
.logic_enable(Logic_Enable),
.cmp_enable(CMP_Enable),
.shift_enable(Shift_Enable) );

Arithmetic_Unit #(.Width (16) ) Arithmetic (
.A(A),
.B(B),
.alu_fun(ALU_FUN [1:0]),
.CLK(CLK),
.arith_enable(Arith_Enable),
.arith_out(Arith_OUT),
.carry_out(Carry_OUT),
.arith_flag(Arith_Flag)		);

Logic_Unit #(.Width (16) ) Logic (
.A(A),
.B(B),
.alu_fun(ALU_FUN [1:0]),
.CLK(CLK),
.logic_enable(Logic_Enable),
.logic_out(Logic_OUT),
.logic_flag(Logic_Flag)		);

CMP_Unit #(.Width (16) ) CMP (
.A(A),
.B(B),
.alu_fun(ALU_FUN [1:0]),
.CLK(CLK),
.cmp_enable(CMP_Enable),
.cmp_out(CMP_OUT),
.cmp_flag(CMP_Flag)		);

Shift_Unit #(.Width (16) ) Shift (
.A(A),
.B(B),
.alu_fun(ALU_FUN [1:0]),
.CLK(CLK),
.shift_enable(Shift_Enable),
.shift_out(Shift_OUT),
.shift_flag(Shift_Flag)		);


endmodule