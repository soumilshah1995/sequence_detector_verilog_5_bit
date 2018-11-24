`define CK2Q 5  // Defines the Clock-to-Q Delay of the flip flop.

module mealy_fsm (reset,clk,in_seq,out_seq);
  input reset;
  input clk;
  input in_seq;
  output out_seq;

  reg out_seq;
  reg in_seq_reg;

  //----------- Parameters defining State machine States--------------
  parameter SIZE = 3;
  parameter  S0 = 3'b000,
				 S1 = 3'b001,
				 S2 = 3'b010,
				 S3 = 3'b011, 
				 S4 = 3'b100;

  //------------ Internal Variables ----------------------------------
  reg   [SIZE-1:0] state;        // Memory part of the FSM
  reg   [SIZE-1:0] next_state;   // Combinational part of the FSM

  //--------------Register the input ---------------------------------
  always @ (posedge clk)
  begin : REG_INPUT
    if (reset == 1'b1) 
       in_seq_reg <= #`CK2Q 1'b0;
     else
       in_seq_reg <= #`CK2Q in_seq;
  end
 
 always @ (state or in_seq_reg or reset)
  begin : FSM_COMBO
    next_state = 3'b00;
	 
    if (reset == 1'b1)
       out_seq <= 1'b0;
     else 
	  begin
      case(state)
       S0 : if (in_seq_reg == 1'b0) begin
               next_state = S1;
      	         out_seq <= 1'b0;
              end 
             else begin
               next_state = S0;
               out_seq <= 1'b0;
              end
       S1 : if (in_seq_reg == 1'b0) begin                
               next_state = S1;
               out_seq <= 1'b0;
              end
             else begin
               next_state = S2;
               out_seq <= 1'b0;
              end


      S2 : if (in_seq_reg == 1'b0) begin
              next_state = S1;
              out_seq <= 1'b0;
             end
            else begin
              next_state = S3;
              out_seq <= 1'b0;
             end
				 
				 
      S3 : if (in_seq_reg == 1'b0) begin
              next_state = S4;
              out_seq <= 1'b0;
             end
            else begin
              next_state = S0;
              out_seq <= 1'b0;
             end
				 
      S4 : if (in_seq_reg == 1'b0) begin
              next_state = S1;
              out_seq <= 1'b0;
             end
            else begin
              next_state = S0;
              out_seq <= 1'b1;
             end				 
				 
				 
     default : begin
                next_state = S0;
                out_seq <= 1'b0;
              end
    endcase
	
    end
end

 // Register combinational “next_state” variable
 always @ (posedge clk)
	 begin:FSM_SEQ

		if(reset == 1'b1)
			state <= S0;
		else
			state <= next_state;
	  end



         // End Of Block OUTPUT_LOGIC
endmodule    // End of Module Mealy state machine
