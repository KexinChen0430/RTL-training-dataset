
module tmds_encoder_24(input  clk,
                       input  rst,
                       input  [7:0] data_in,
                       input  c0,
                       input  c1,
                       input  de,
                       output reg [9:0] data_out);

  reg  [9:0] M_dout_d, M_dout_q = 1'h0;
  reg  [4:0] M_count_d, M_count_q = 1'h0;
  reg  [3:0] M_num_ones_d, M_num_ones_q = 1'h0;
  reg  [7:0] M_din_d, M_din_q = 1'h0;
  reg  [3:0] M_num_ones9_d, M_num_ones9_q = 1'h0;
  reg  [1:0] M_c0_pipe_d, M_c0_pipe_q = 1'h0;
  reg  [1:0] M_c1_pipe_d, M_c1_pipe_q = 1'h0;
  reg  [1:0] M_de_pipe_d, M_de_pipe_q = 1'h0;
  reg  [8:0] M_data9_pipe_d, M_data9_pipe_q = 1'h0;
  reg  xor_flag;
  reg  [8:0] data9;
  integer i;
  reg  cond_flip;
  reg  flip;

  
  always @* 
      begin
        M_c1_pipe_d = M_c1_pipe_q;
        M_din_d = M_din_q;
        M_count_d = M_count_q;
        M_data9_pipe_d = M_data9_pipe_q;
        M_num_ones9_d = M_num_ones9_q;
        M_de_pipe_d = M_de_pipe_q;
        M_num_ones_d = M_num_ones_q;
        M_dout_d = M_dout_q;
        M_c0_pipe_d = M_c0_pipe_q;
        data_out = M_dout_q;
        M_c0_pipe_d = {M_c0_pipe_q[0 -: 1],c0};
        M_c1_pipe_d = {M_c1_pipe_q[0 -: 1],c1};
        M_de_pipe_d = {M_de_pipe_q[0 -: 1],de};
        M_num_ones_d = data_in[6 -: 1]+((data_in[4 -: 1]+data_in[7 -: 1])+(((data_in[0 -: 1]+data_in[1 -: 1])+data_in[5 -: 1])+(data_in[1+1 -: 1]+data_in[3 -: 1])));
        M_din_d = data_in;
        xor_flag = (M_num_ones_q > 3'h4) || 
                   (((M_num_ones_q > 3'h4) || (M_num_ones_q == 3'h4)) && 
((M_din_q[0 -: 1] == 1'h0) && (M_num_ones_q == 3'h4)));
        data9[0 -: 1] = M_din_q[0 -: 1];
        for (i = 1'h1; i < 4'h8; i = 1+i)
            begin
              data9[i -: 1] = xor_flag ? ~(((M_din_q[i -: 1] | ~M_din_q[i -: 1]) & ((data9[(-1'h1)+i -: 1] | ~data9[(-1'h1)+i -: 1]) & M_din_q[i -: 1])) ^ ((M_din_q[i -: 1] | ~M_din_q[i -: 1]) & data9[(-1'h1)+i -: 1])) : (((M_din_q[i -: 1] | ~M_din_q[i -: 1]) & ((data9[(-1'h1)+i -: 1] | ~data9[(-1'h1)+i -: 1]) & M_din_q[i -: 1])) ^ ((M_din_q[i -: 1] | ~M_din_q[i -: 1]) & data9[(-1'h1)+i -: 1]));
            end
        data9[8 -: 1] = ~xor_flag;
        M_num_ones9_d = (data9[4 -: 1]+((data9[1 -: 1]+(data9[3 -: 1]+data9[0 -: 1]))+(data9[1+1 -: 1]+data9[5 -: 1])))+(data9[6 -: 1]+data9[7 -: 1]);
        M_data9_pipe_d = data9;
        cond_flip = (M_num_ones9_q == 3'h4) || (M_count_q == 1'h0);
        flip = 
(
((M_count_q[4 -: 1] || ~M_count_q[4 -: 1]) && 
(M_num_ones9_q > 3'h4)) || 
((M_count_q[4 -: 1] || (M_num_ones9_q > 3'h4)) && 
(((3'h4 > M_num_ones9_q) && M_count_q[4 -: 1]) || 
(~M_count_q[4 -: 1] && (3'h4 > M_num_ones9_q))))) && ((3'h4 > M_num_ones9_q) || ~M_count_q[4 -: 1]);
        if (M_de_pipe_q[1 -: 1]) 
          begin
            if (cond_flip) 
              begin
                M_dout_d[9 -: 1] = ~M_data9_pipe_q[8 -: 1];
                M_dout_d[8 -: 1] = M_data9_pipe_q[8 -: 1];
                M_dout_d[7 -: 8] = M_data9_pipe_q[8 -: 1] ? M_data9_pipe_q[7 -: 8] : ~M_data9_pipe_q[7 -: 8];
                M_count_d = ~M_data9_pipe_q[8 -: 1] ? ((M_count_q+(4'h8-M_num_ones9_q))+(-M_num_ones9_q)) : (M_num_ones9_q+(M_count_q+(-(4'h8-M_num_ones9_q))));
              end
            else 
              begin
                if (flip) 
                  begin
                    M_dout_d[9 -: 1] = 1'h1;
                    M_dout_d[8 -: 1] = M_data9_pipe_q[8 -: 1];
                    M_dout_d[7 -: 8] = ~M_data9_pipe_q[7 -: 8];
                    M_count_d = ((-M_num_ones9_q)+M_count_q)+((4'h8-M_num_ones9_q)+{M_data9_pipe_q[8 -: 1],1'h0});
                  end
                else 
                  begin
                    M_dout_d[9 -: 1] = 1'h0;
                    M_dout_d[8 -: 9] = M_data9_pipe_q[8 -: 9];
                    M_count_d = ((M_count_q+M_num_ones9_q)+(-{~M_data9_pipe_q[8 -: 1],1'h0}))+(-(4'h8-M_num_ones9_q));
                  end
              end
          end
        else 
          begin
            case ({M_c1_pipe_q[1 -: 1],M_c0_pipe_q[1 -: 1]})

              2'h0: begin
                    M_dout_d = 10'h354;
                  end

              2'h1: begin
                    M_dout_d = 10'h0ab;
                  end

              2'h2: begin
                    M_dout_d = 10'h154;
                  end

              default: begin
                    M_dout_d = 10'h2ab;
                  end

            endcase

            M_count_d = 1'h0;
          end
      end
  
  always @(posedge clk)
      begin
        M_num_ones_q <= M_num_ones_d;
        M_din_q <= M_din_d;
        M_num_ones9_q <= M_num_ones9_d;
        M_c0_pipe_q <= M_c0_pipe_d;
        M_c1_pipe_q <= M_c1_pipe_d;
        M_de_pipe_q <= M_de_pipe_d;
        M_data9_pipe_q <= M_data9_pipe_d;
        if (rst == 1'b1) 
          begin
            M_dout_q <= 1'h0;
            M_count_q <= 1'h0;
          end
        else 
          begin
            M_dout_q <= M_dout_d;
            M_count_q <= M_count_d;
          end
      end
endmodule

