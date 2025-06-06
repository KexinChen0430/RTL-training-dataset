
module nmievents(input  wire clk,
                 input  wire rst_n,
                 input  wire [7:0] zxuno_addr,
                 input  wire zxuno_regrd,
                 input  wire [4:0] userevents,
                 input  wire [15:0] a,
                 input  wire m1_n,
                 input  wire mreq_n,
                 input  wire rd_n,
                 output wire [7:0] dout,
                 output wire oe_n,
                 output reg nmiout_n,
                 output reg page_configrom_active);

  parameter  NMIEVENT = 8'h08;
  parameter  IDLE = 1'd0, ABOUT_TO_EXIT = 1'd1;

  
  initial    page_configrom_active = 1'b0;
  
  initial    nmiout_n = 1'b1;
  reg   state = IDLE;

  reg  [7:0]  nmieventreg = 8'h00;

  assign dout = nmieventreg;
  assign oe_n = ~((zxuno_regrd == 1'b1) && (zxuno_addr == NMIEVENT));
  
  always @(posedge clk)
      begin
        if (rst_n == 1'b0) 
          begin
            nmieventreg <= 8'h00;
            page_configrom_active <= 1'b0;
            state <= IDLE;
          end
        else 
          begin
            if ((page_configrom_active == 1'b0) && 
                (userevents != 5'b00000)) 
              begin
                nmieventreg <= {3'b000,userevents};
                nmiout_n <= 1'b0;
                page_configrom_active <= 1'b1;
                state <= IDLE;
              end
              
            if ((mreq_n == 1'b0) && (m1_n == 1'b0) && 
                ((a == 16'h0066) && (page_configrom_active == 1'b1))) nmiout_n <= 1'b1;
              
            case (state)

              IDLE: begin
                    if ((a == 16'h006A) && 
                        ((mreq_n == 1'b0) && (m1_n == 1'b0)) && 
                        ((page_configrom_active == 1'b1) && (rd_n == 1'b0))) state <= ABOUT_TO_EXIT;
                      
                  end

              ABOUT_TO_EXIT: begin
                    if (m1_n == 1'b1) 
                      begin
                        page_configrom_active <= 1'b0;
                        nmieventreg <= 8'h00;
                        state <= IDLE;
                      end
                      
                  end

              default: state <= IDLE;

            endcase

          end
      end
endmodule

