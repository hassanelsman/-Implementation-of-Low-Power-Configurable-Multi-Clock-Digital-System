//module name and ports declarations
module Register_File_8x16 (

input wire	[15:0]	WrData,
input wire	[2:0]	Address,
input wire			WrEn,
input wire			RdEn,
input wire			CLK,
input wire			RST,
output reg	[15:0]	RdData 	) ;

//2D array declaration

reg [15:0]	RegFile	[7:0]  ;


always @(posedge CLK , negedge RST)
begin
 if (!RST)
  begin
   RegFile [0] <= 16'b0 ;
   RegFile [1] <= 16'b0 ;
   RegFile [2] <= 16'b0 ;
   RegFile [3] <= 16'b0 ;
   RegFile [4] <= 16'b0 ;
   RegFile [5] <= 16'b0 ;
   RegFile [6] <= 16'b0 ;
   RegFile [7] <= 16'b0 ;
   RdData <= 16'b0 ;
  end
  
 else
 
  begin
   if (WrEn)//assume writing has priorty 
    begin
	 RegFile [Address] <= WrData ;
	 RdData <= 16'b0 ; //to avide latching 2 - 2x1 MUXs  NOTE important as it is a sequential block
	end
   else if (RdEn && WrEn == 1'b0)
    begin
     RdData <= RegFile [Address] ;
	end
  end


end


endmodule


