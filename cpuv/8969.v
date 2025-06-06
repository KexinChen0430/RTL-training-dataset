module outputs) 
   wire                 clk;                    
   wire                 r0;                     
   wire                 a1;                     
   wire                 a2;                     
   localparam OUT_STATE_DISABLED  = 2'b00;      
   localparam OUT_STATE_STARTING  = 2'b01;      
   localparam OUT_STATE_STABLE    = 2'b10;      
   localparam OUT_STATE_DISABLING = 2'b11;      
   reg [1:0]            state_r;                
   reg [1:0]            state_nxt;              
   reg                 r0_a,a1_a,a2_a;          
   reg                 r0_r,a1_r,a2_r;          
   dualffsync U_SYNC_R1 (
                         .out_r                 (r1_r),
                         .in                    (r1),            
                         .clk                   (clk),
                         .reset_n               (reset_n));
   dualffsync U_SYNC_R2 (
                         .out_r                 (r2_r),
                         .in                    (r2),            
                         .clk                   (clk),
                         .reset_n               (reset_n));
   dualffsync U_SYNC_A0 (
                         .out_r                 (a0_r),
                         .in                    (a0),            
                         .clk                   (clk),
                         .reset_n               (reset_n));
   assign unstable = (r1 ^ a1) | (r2 ^ a2) | (r1_r ^ a1) | (r2_r ^ a2) | (a0 ^ a0_r);
   assign clock_stopped = !unstable;
   pausible_clock U_PAUSIBLE_CLOCK (
                                    .req                (clock_stopped),
                                    .grant              (),
                                    .clock              (clk),           
                                    .rstn               (reset_n));       
   always @(posedge clk or negedge reset_n) begin
      if(reset_n == 1'b0) begin
         state_r <= OUT_STATE_DISABLED;
         a1_r <= 1'h0;
         a2_r <= 1'h0;
         r0_r <= 1'h0;
      end
      else begin
         state_r <= state_r;
         a1_r <= a1_a;
         a2_r <= a2_a;
         r0_r <= r0_a;
      end
   end
   always @* begin
      case(state_r)
        OUT_STATE_DISABLED: begin
           a1_a <= 0;
           a2_a <= 0;
           if(r1_r || r2_r) begin
              r0_a <= 1;
              state_nxt <= OUT_STATE_STARTING;
           end
           else begin
             r0_a <= 0;
             state_nxt <= OUT_STATE_DISABLED;
           end
        end
        OUT_STATE_STARTING: begin
           r0_a <= 1;
           if(a0_r) begin
              state_nxt <= OUT_STATE_STABLE;
              a1_a <= r1_r;
              a2_a <= r2_r;
           end
           else begin
              state_nxt <= OUT_STATE_STARTING;
              a1_a <= a1_r;
              a2_a <= a2_r;
           end
        end
        OUT_STATE_STABLE: begin
           r0_a <= 1;
           if((!r1_r) && (!r2_r)) begin
             state_nxt <= OUT_STATE_DISABLING;
              a1_a <= a1_r;
              a2_a <= a2_r;
           end
           else begin
              state_nxt <= OUT_STATE_STABLE;
              a1_a <= r1_r;
              a2_a <= r2_r;
           end
        end
        OUT_STATE_DISABLING: begin
           r0_a <= 0;
           if(!a0_r) begin
              state_nxt <= OUT_STATE_DISABLED;
              a1_a <= 0;
              a2_a <= 0;
           end
           else begin
              state_nxt <= OUT_STATE_DISABLING;
              a1_a <= a1_r;
              a2_a <= a2_r;
           end
        end
        default: begin
        end
      endcase
   end
   assign a1 = a1_r;
   assign a2 = a2_r;
   assign r0 = r0_r;
endmodule 