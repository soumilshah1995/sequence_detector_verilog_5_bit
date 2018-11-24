module fsm_bench();
wire clk, reset, in_seq, out_seq;
test_fsm test (.reset(reset), .clk(clk), .in_seq(in_seq), .out_seq(out_seq));
mealy_fsm fsm0 (.reset(reset), .clk(clk), .in_seq(in_seq), .out_seq(out_seq));
endmodule