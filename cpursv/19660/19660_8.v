
module fapch_zek(input  wire fclk,
                 input  wire rdat_n,
                 output reg vg_rclk,
                 output reg vg_rawr);

  reg  [3:0] rdat_sr;
  reg  rawr_sync;
  reg  rdat_n_r;

  
  always @(posedge fclk)
      begin
        rdat_n_r <= rdat_n;
        rdat_sr <= {rdat_sr[1<<<1:0],rdat_n_r};
        if ((rdat_sr == 4'h0) || (rdat_sr == 4'hF)) rawr_sync <= rdat_sr[3];
          
      end
  reg  [4:0] rawr_sr;

  
  always @(posedge fclk)
      begin
        rawr_sr <= {rawr_sr[3:0],rawr_sync};
        vg_rawr <= !(!rawr_sr[0] && rawr_sr[4]);
      end
  reg  [5:0]  counter = 0;

  wire [5:0]  delta = (0-counter)+27;

  wire [5:0]  shift = {delta[5],delta[5],delta[4:1]};

  wire [5:0]  inc = (rawr_sr[1:0] == 2'b10) ? shift : 1;

  
  always @(posedge fclk)
      begin
        if (counter < 55) counter <= inc+counter;
        else 
          begin
            counter <= 0;
            vg_rclk = ~vg_rclk;
          end
      end
  
  initial    vg_rclk = 0;
endmodule

