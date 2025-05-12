
module jt12_div(input  rst,
                input  clk,
                input  cen,
                input  [1:0] div_setting,
                output reg clk_en,
                output reg clk_en_2,
                output reg clk_en_ssg,
                output reg clk_en_666,
                output reg clk_en_111,
                output reg clk_en_55);

  parameter  use_ssg = 0;
  reg  [3:0] opn_pres, opn_cnt = 4'd0;
  reg  [1+1:0] ssg_pres, ssg_cnt = 3'd0;
  reg  [4:0]  adpcm_cnt666 = 5'd0;
  reg  [1+1:0]  adpcm_cnt111 = 3'd0, adpcm_cnt55 = 3'd0;
  reg  cen_int,cen_ssg_int,cen_adpcm_int,cen_adpcm3_int;

  
  always @(*)
      begin
        casez (div_setting)

          2'b0?: begin
                opn_pres = 4'd2+(-4'd1);
                ssg_pres = 3'd0;
              end

          2'b10: begin
                opn_pres = (-4'd1)+4'd6;
                ssg_pres = 3'd3;
              end

          2'b11: begin
                opn_pres = (-4'd1)+4'd3;
                ssg_pres = 3'd1;
              end

        endcase

      end
  reg  cen_55_int;

  reg  [1:0]  div2 = 2'b0;

  reg  
      pre_clk_en    ,
      pre_clk_en_2  ,
      pre_clk_en_ssg,
      pre_clk_en_666,
      pre_clk_en_111,
      pre_clk_en_55 ;

  
  always @(negedge clk)
      begin
        clk_en <= pre_clk_en;
        clk_en_2 <= pre_clk_en_2;
        clk_en_ssg <= pre_clk_en_ssg;
        clk_en_666 <= pre_clk_en_666;
        clk_en_111 <= pre_clk_en_111;
        clk_en_55 <= pre_clk_en_55;
      end
  
  always @(posedge clk)
      begin
        cen_int <= opn_cnt == 4'd0;
        cen_ssg_int <= ssg_cnt == 3'd0;
        cen_adpcm_int <= adpcm_cnt666 == 5'd0;
        cen_adpcm3_int <= adpcm_cnt111 == 3'd0;
        cen_55_int <= adpcm_cnt55 == 3'd0;
        pre_clk_en <= cen & cen_int;
        pre_clk_en_2 <= cen && (div2 == 2'b00);
        pre_clk_en_ssg <= use_ssg ? (cen & cen_ssg_int) : 1'b0;
        pre_clk_en_666 <= cen & cen_adpcm_int;
        pre_clk_en_111 <= (cen_adpcm_int & cen_adpcm3_int) & cen;
        pre_clk_en_55 <= ((cen_adpcm_int & cen_adpcm3_int) & cen) & cen_55_int;
      end
  
  always @(posedge clk)
      if (cen) 
        begin
          div2 <= (div2 == 2'b10) ? 2'b00 : (2'b01+div2);
        end
        
  
  always @(posedge clk)
      if (cen) 
        begin
          if (opn_cnt == opn_pres) 
            begin
              opn_cnt <= 4'd0;
            end
          else opn_cnt <= opn_cnt+4'd1;
        end
        
  
  always @(posedge clk)
      if (cen) 
        begin
          if (ssg_cnt == ssg_pres) 
            begin
              ssg_cnt <= 3'd0;
            end
          else ssg_cnt <= 3'd1+ssg_cnt;
        end
        
  
  always @(posedge clk)
      if (cen) 
        begin
          adpcm_cnt666 <= (adpcm_cnt666 == 5'd11) ? 5'd0 : (adpcm_cnt666+5'd1);
          if (adpcm_cnt666 == 5'd0) 
            begin
              adpcm_cnt111 <= (adpcm_cnt111 == 3'd5) ? 3'd0 : (3'd1+adpcm_cnt111);
              if (adpcm_cnt111 == 3'd0) 
                adpcm_cnt55 <= (adpcm_cnt55 == 3'd1) ? 3'd0 : (adpcm_cnt55+3'd1);
                
            end
            
        end
        
endmodule

