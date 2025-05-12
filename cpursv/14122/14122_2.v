
module hardcopyiv_delay_chain(datain,delayctrlin,finedelayctrlin,devclrn,devpor,dataout);

  parameter  sim_delayctrlin_rising_delay_0 = 0;
  parameter  sim_delayctrlin_rising_delay_15 = 750;
  parameter  sim_delayctrlin_falling_delay_0 = 0;
  parameter  sim_delayctrlin_falling_delay_15 = 750;
  parameter  sim_finedelayctrlin_falling_delay_0 = 0;
  parameter  sim_finedelayctrlin_falling_delay_1 = 25;
  parameter  sim_finedelayctrlin_rising_delay_0 = 0;
  parameter  sim_finedelayctrlin_rising_delay_1 = 25;
  parameter  use_finedelayctrlin = false;
  parameter  lpm_type = hardcopyiv_delay_chain;
  parameter  use_delayctrlin = true;
  parameter  delay_setting = 0;
  input  datain;
  input  [3:0] delayctrlin;
  input  devclrn;
  input  devpor;
  input  finedelayctrlin;
  output dataout;
  tri1 devclrn;
  tri1 devpor;
  integer dly_table_rising[0:15];
  integer dly_table_falling[0:15];
  integer finedly_table_rising[0:1];
  integer finedly_table_falling[0:1];
  integer dly_setting;
  integer rising_dly,falling_dly;
  reg  tmp_dataout;
  wire datain_in;
  wire [3:0] delayctrlin_in;
  wire finedelayctrlin_in;

  assign datain_in = datain;
  
  specify
    (datain => dataout) = (0,0);
  endspecify

  assign delayctrlin_in[0] = (delayctrlin[0] === 1'b1) ? 1'b1 : 1'b0;
  assign finedelayctrlin_in = (finedelayctrlin === 1'b1) ? 1'b1 : 1'b0;
  
  initial  
  begin
    dly_setting = 0;
    rising_dly = 0;
    falling_dly = 0;
    tmp_dataout = 1'bx;
  end
  
  always @(delayctrlin_in or finedelayctrlin_in)
      begin
        if (use_delayctrlin == false) dly_setting = delay_setting;
        else dly_setting = delayctrlin_in;
        if (use_finedelayctrlin == true) 
          begin
            rising_dly = dly_table_rising[dly_setting]+finedly_table_rising[finedelayctrlin_in];
            falling_dly = dly_table_falling[dly_setting]+finedly_table_falling[finedelayctrlin_in];
          end
        else 
          begin
            rising_dly = dly_table_rising[dly_setting];
            falling_dly = dly_table_falling[dly_setting];
          end
      end
  
  always @(datain_in)
      begin
        if (datain_in === 1'b0) tmp_dataout <= #(falling_dly) datain_in;
        else tmp_dataout <= #(rising_dly) datain_in;
      end
  assign dataout = tmp_dataout;
endmodule

