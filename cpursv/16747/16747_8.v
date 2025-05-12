
module valid_generator(clock,resetn,i_valid,o_stall,i_thread_count,o_valid,i_stall);

  parameter  MAX_THREADS = 64;
  localparam  NUM_THREAD_BITS = 1+$clog2(MAX_THREADS);
  input  clock,resetn,i_valid,i_stall;
  input  [NUM_THREAD_BITS-1:0] i_thread_count;
  output o_valid;
  output o_stall;
  reg  [NUM_THREAD_BITS:0] local_thread_count;
  reg  valid_sr;
  reg  valid_reg;
  wire stall_counter;

  assign o_stall = local_thread_count[NUM_THREAD_BITS];
  
  always @(posedge clock or negedge resetn)
      begin
        if (~resetn) 
          begin
            local_thread_count <= {{NUM_THREAD_BITS}{1'b0}};
          end
        else 
          begin
            local_thread_count <= (local_thread_count+{{1+NUM_THREAD_BITS}{|local_thread_count & ~stall_counter}})+{1'b0,{{NUM_THREAD_BITS}{i_valid & ~o_stall}} & i_thread_count};
          end
      end
  assign stall_counter = valid_reg & valid_sr;
  
  always @(posedge clock or negedge resetn)
      begin
        if (~resetn) 
          begin
            valid_reg <= 1'b0;
          end
        else 
          begin
            if (~stall_counter) 
              begin
                valid_reg <= |local_thread_count;
              end
              
          end
      end
  
  always @(posedge clock or negedge resetn)
      begin
        if (~resetn) 
          begin
            valid_sr <= 1'b0;
          end
        else 
          begin
            valid_sr <= valid_sr ? i_stall : (i_stall & valid_reg);
          end
      end
  assign o_valid = valid_sr | valid_reg;
endmodule

