module fifo_flags (push, pop, flags, clk, rst_n);
   input push, pop;
   output fifov_flags_t flags;
   input clk, rst_n;
   parameter size = 8;
   parameter init_fifo_contents = 0;
   reg [size:0]   counter;      
   logic 	  was_push, was_pop;
   fifov_flags_t flags_reg;
   logic 	  add, sub, same;
   logic 	  fast_empty;
   always@(posedge clk) begin
      if (!rst_n) begin
	 if (init_fifo_contents==2) begin
	    counter<={{(size-1){1'b0}},2'b10};
	 end else if (init_fifo_contents==1) begin
	    counter<={2'b01,{(size-1){1'b0}}};
	 end else begin
	    counter<={{size{1'b0}},1'b1};
	 end
	 was_push<=1'b0;
	 was_pop<=1'b0;
	 fast_empty <=1'b1;
      end else begin
 	 if (add) begin
	    assert (counter!={1'b1,{size{1'b0}}}) else $fatal;
	    counter <= {counter[size-1:0], 1'b0};
	 end else if (sub) begin
	    assert (counter!={{size{1'b0}},1'b1}) else $fatal;
	    counter <= {1'b0, counter[size:1]};
	 end
	 assert (counter!=0) else $fatal;
	 was_push<=push;
	 was_pop<=pop;
	 assert (push!==1'bx) else $fatal;
	 assert (pop!==1'bx) else $fatal;
	 fast_empty <= (flags.empty && !push && !pop) || (flags.nearly_empty && pop && !push);
      end 
   end
   assign add = was_push && !was_pop;
   assign sub = was_pop && !was_push;
   assign same = !(add || sub);
   assign flags.full = (counter[size] && !sub) || (counter[size-1] && add);
   assign flags.empty = (counter[0] && !add) || (counter[1] && sub);
   assign flags.nearly_full = (counter[size-1:0] && same) || (counter[size] && sub) || (counter[size-2] && add);
   assign flags.nearly_empty = (counter[1] && same) || (counter[0] && add) || (counter[2] && sub);
   assign flags.fast_empty = fast_empty;
endmodule