module test_fsm(reset, clk, in_seq, out_seq);
// declare input and outputs 
output reset, clk, in_seq;
reg reset, clk, in_seq;
input out_seq;

reg[15:0] data;
integer i;

// The input data sequence is defined in the bit
// vector "data". On each clock one bit of data is
// sent to the state machine which will detect the
// sequence "101" in this data

initial
begin
	data=16'b011011011101101;
	i=0;
	reset=1'b1;
	#1200;
	reset = 1'b0;
	#20000;
	$finish;
end
initial
begin
	clk=0;
	forever begin
					#600;
					clk=~clk;
				end
end
always @ (posedge clk)
begin
	#50;
	in_seq= data >> i;
	i=i+1;
end
endmodule

					