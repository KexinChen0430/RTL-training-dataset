module n64rgb_hk (
  input      VCLK,                   
  input      nRST,                   
  output reg DRV_RST,                
  input CTRL_i,                      
  input n64_480i,                    
  input n16bit_mode_t,               
  input nVIDeBlur_t,                 
  input en_IGR_Rst_Func,             
  input en_IGR_DeBl_16b_Func,        
  output reg n16bit_o,               
  output reg nDeBlur_o               
);
`include "vh/igr_params.vh"          
reg       CLK_4M      = 1'b0;        
reg [2:0] div_clk_cnt = 3'b000;      
always @(posedge VCLK) begin
  if (div_clk_cnt == 3'b101) begin
    CLK_4M      <= ~CLK_4M;          
    div_clk_cnt <= 3'b000;           
  end else
    div_clk_cnt <= div_clk_cnt + 1'b1; 
end
reg [1:0] rd_state  = 2'b0;          
localparam ST_WAIT4N64 = 2'b00;      
localparam ST_N64_RD   = 2'b01;      
localparam ST_CTRL_RD  = 2'b10;      
reg [7:0] wait_cnt     = 8'h0;       
reg [2:0] ctrl_hist    = 3'h7;       
wire      ctrl_negedge =  ctrl_hist[2] & !ctrl_hist[1]; 
wire      ctrl_posedge = !ctrl_hist[2] &  ctrl_hist[1]; 
reg [7:0] ctrl_low_cnt = 8'h0;       
wire      ctrl_bit     = ctrl_low_cnt < wait_cnt;       
reg [15:0] serial_data = 16'h0;      
reg  [3:0] data_cnt    =  4'h0;       
reg [1:0] n16bit_mode_hist = 2'b11;  
reg [1:0] nVIDeBlur_hist = 2'b11;    
reg initiate_nrst = 1'b0;            
reg nfirstboot = 1'b0;               
always @(posedge CLK_4M) begin
  case (rd_state)
    ST_WAIT4N64:
      if (&wait_cnt) begin 
        rd_state <= ST_N64_RD;
        data_cnt <= 4'h0;
      end
    ST_N64_RD: begin
      if (ctrl_posedge)       
        ctrl_low_cnt <= wait_cnt;
      if (ctrl_negedge) begin 
        if (!data_cnt[3]) begin  
          serial_data[13:6] <= {ctrl_bit,serial_data[13:7]};
          data_cnt          <= data_cnt + 1'b1;
        end else if (serial_data[13:6] == 8'b10000000) begin 
          rd_state <= ST_CTRL_RD;
          data_cnt <=  4'h0;
        end else begin
          rd_state <= ST_WAIT4N64;
        end
      end
    end
    ST_CTRL_RD: begin
      if (ctrl_posedge)       
        ctrl_low_cnt <= wait_cnt;
      if (ctrl_negedge) begin 
        if (~&data_cnt) begin  
          data_cnt    <= data_cnt + 1'b1;
          serial_data <= {ctrl_bit,serial_data[15:1]};
        end else begin        
          rd_state <= ST_WAIT4N64;
          if (en_IGR_DeBl_16b_Func)
            case ({ctrl_bit,serial_data[15:1]})
              `IGR_16BITMODE_OFF: n16bit_o <= 1'b1;
              `IGR_16BITMODE_ON: n16bit_o <= 1'b0;
              `IGR_DEBLUR_OFF: nDeBlur_o <= 1'b1;
              `IGR_DEBLUR_ON: nDeBlur_o <= 1'b0;
            endcase
          if (en_IGR_Rst_Func & ({ctrl_bit,serial_data[15:1]} == `IGR_RESET))
              initiate_nrst <= 1'b1;
        end
      end
    end
    default: begin
      rd_state <= ST_WAIT4N64;
    end
  endcase
  if (ctrl_negedge | ctrl_posedge) begin 
    wait_cnt <= 8'h0;
  end else begin
    if (~&wait_cnt) 
      wait_cnt <= wait_cnt + 1'b1;
    else            
      rd_state <= ST_WAIT4N64;
  end
  if (^n16bit_mode_hist)
    n16bit_o  <= n16bit_mode_t;
  if (^nVIDeBlur_hist)
    nDeBlur_o <= nVIDeBlur_t;
  ctrl_hist <= {ctrl_hist[1:0],CTRL_i};
  n16bit_mode_hist <= {n16bit_mode_hist[0],n16bit_mode_t};
  nVIDeBlur_hist <= {nVIDeBlur_hist[0],nVIDeBlur_t};
  if (!nRST) begin
    rd_state      <= ST_WAIT4N64;
    wait_cnt      <= 8'h0;
    ctrl_hist     <= 3'h7;
    initiate_nrst <= 1'b0;
  end
  if (!nfirstboot) begin
    nfirstboot <= 1'b1;
    nDeBlur_o <= nVIDeBlur_t;
    n16bit_o <=  n16bit_mode_t;
    n16bit_mode_hist <= {2{n16bit_mode_t}};
    nVIDeBlur_hist <= {2{nVIDeBlur_t}};
  end
end
reg [17:0] rst_cnt = 18'b0; 
always @(posedge CLK_4M) begin
  if (initiate_nrst == 1'b1) begin
    DRV_RST <= 1'b1;      
    rst_cnt <= 18'h3ffff;
  end else if (|rst_cnt) 
    rst_cnt <= rst_cnt - 1'b1;
  else
    DRV_RST <= 1'b0; 
end
endmodule