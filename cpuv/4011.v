module hardcopyiii_delay_chain (
 	    datain,
 	    delayctrlin,
 	    finedelayctrlin,
 	    devclrn,
 	    devpor,
 	    dataout
 );
 parameter sim_delayctrlin_rising_delay_0  = 0;
 parameter sim_delayctrlin_rising_delay_1  = 50;
 parameter sim_delayctrlin_rising_delay_2  = 100;
 parameter sim_delayctrlin_rising_delay_3  = 150;
 parameter sim_delayctrlin_rising_delay_4  = 200;
 parameter sim_delayctrlin_rising_delay_5  = 250;
 parameter sim_delayctrlin_rising_delay_6  = 300;
 parameter sim_delayctrlin_rising_delay_7  = 350;
 parameter sim_delayctrlin_rising_delay_8  = 400;
 parameter sim_delayctrlin_rising_delay_9  = 450;
 parameter sim_delayctrlin_rising_delay_10  = 500;
 parameter sim_delayctrlin_rising_delay_11  = 550;
 parameter sim_delayctrlin_rising_delay_12  = 600;
 parameter sim_delayctrlin_rising_delay_13  = 650;
 parameter sim_delayctrlin_rising_delay_14  = 700;
 parameter sim_delayctrlin_rising_delay_15  = 750;
 parameter sim_delayctrlin_falling_delay_0  = 0;
 parameter sim_delayctrlin_falling_delay_1  = 50;
 parameter sim_delayctrlin_falling_delay_2  = 100;
 parameter sim_delayctrlin_falling_delay_3  = 150;
 parameter sim_delayctrlin_falling_delay_4  = 200;
 parameter sim_delayctrlin_falling_delay_5  = 250;
 parameter sim_delayctrlin_falling_delay_6  = 300;
 parameter sim_delayctrlin_falling_delay_7  = 350;
 parameter sim_delayctrlin_falling_delay_8  = 400;
 parameter sim_delayctrlin_falling_delay_9  = 450;
 parameter sim_delayctrlin_falling_delay_10  = 500;
 parameter sim_delayctrlin_falling_delay_11  = 550;
 parameter sim_delayctrlin_falling_delay_12  = 600;
 parameter sim_delayctrlin_falling_delay_13  = 650;
 parameter sim_delayctrlin_falling_delay_14  = 700;
 parameter sim_delayctrlin_falling_delay_15  = 750;
 parameter sim_finedelayctrlin_falling_delay_0 =  0 ;
 parameter sim_finedelayctrlin_falling_delay_1 =  25 ;
 parameter sim_finedelayctrlin_rising_delay_0  =  0 ;
 parameter sim_finedelayctrlin_rising_delay_1  =  25 ;
 parameter use_finedelayctrlin                 = "false";
 parameter lpm_type = "hardcopyiii_delay_chain";
 parameter use_delayctrlin = "true";
 parameter delay_setting   = 0; 
 input        datain;
 input  [3:0] delayctrlin;
 input        devclrn;
 input        devpor;
 input        finedelayctrlin;  
 output       dataout;
 tri1 devclrn;
 tri1 devpor;
 integer      dly_table_rising[0:15];
 integer      dly_table_falling[0:15];
 integer      finedly_table_rising[0:1];
 integer      finedly_table_falling[0:1];
 integer      dly_setting;
 integer      rising_dly, falling_dly;
 reg          tmp_dataout;
 wire        datain_in;
 wire [3:0]  delayctrlin_in;
 wire        finedelayctrlin_in;
 assign datain_in = datain;
 specify
     (datain => dataout) = (0,0);
 endspecify
 assign delayctrlin_in[0] = (delayctrlin[0] === 1'b1) ? 1'b1 : 1'b0;
 assign delayctrlin_in[1] = (delayctrlin[1] === 1'b1) ? 1'b1 : 1'b0;
 assign delayctrlin_in[2] = (delayctrlin[2] === 1'b1) ? 1'b1 : 1'b0;
 assign delayctrlin_in[3] = (delayctrlin[3] === 1'b1) ? 1'b1 : 1'b0;
 assign finedelayctrlin_in = (finedelayctrlin === 1'b1) ? 1'b1 : 1'b0;
 initial
 begin
     dly_table_rising[0] = sim_delayctrlin_rising_delay_0;
     dly_table_rising[1] = sim_delayctrlin_rising_delay_1;
     dly_table_rising[2] = sim_delayctrlin_rising_delay_2;
     dly_table_rising[3] = sim_delayctrlin_rising_delay_3;
     dly_table_rising[4] = sim_delayctrlin_rising_delay_4;
     dly_table_rising[5] = sim_delayctrlin_rising_delay_5;
     dly_table_rising[6] = sim_delayctrlin_rising_delay_6;
     dly_table_rising[7] = sim_delayctrlin_rising_delay_7;
     dly_table_rising[8] = sim_delayctrlin_rising_delay_8;
     dly_table_rising[9] = sim_delayctrlin_rising_delay_9;
     dly_table_rising[10] = sim_delayctrlin_rising_delay_10;
     dly_table_rising[11] = sim_delayctrlin_rising_delay_11;
     dly_table_rising[12] = sim_delayctrlin_rising_delay_12;
     dly_table_rising[13] = sim_delayctrlin_rising_delay_13;
     dly_table_rising[14] = sim_delayctrlin_rising_delay_14;
     dly_table_rising[15] = sim_delayctrlin_rising_delay_15;
     dly_table_falling[0] = sim_delayctrlin_falling_delay_0;
     dly_table_falling[1] = sim_delayctrlin_falling_delay_1;
     dly_table_falling[2] = sim_delayctrlin_falling_delay_2;
     dly_table_falling[3] = sim_delayctrlin_falling_delay_3;
     dly_table_falling[4] = sim_delayctrlin_falling_delay_4;
     dly_table_falling[5] = sim_delayctrlin_falling_delay_5;
     dly_table_falling[6] = sim_delayctrlin_falling_delay_6;
     dly_table_falling[7] = sim_delayctrlin_falling_delay_7;
     dly_table_falling[8] = sim_delayctrlin_falling_delay_8;
     dly_table_falling[9] = sim_delayctrlin_falling_delay_9;
     dly_table_falling[10] = sim_delayctrlin_falling_delay_10;
     dly_table_falling[11] = sim_delayctrlin_falling_delay_11;
     dly_table_falling[12] = sim_delayctrlin_falling_delay_12;
     dly_table_falling[13] = sim_delayctrlin_falling_delay_13;
     dly_table_falling[14] = sim_delayctrlin_falling_delay_14;
     dly_table_falling[15] = sim_delayctrlin_falling_delay_15;
     finedly_table_rising[0]  = sim_finedelayctrlin_rising_delay_0;
     finedly_table_rising[1]  = sim_finedelayctrlin_rising_delay_1;
     finedly_table_falling[0] = sim_finedelayctrlin_falling_delay_0;
     finedly_table_falling[1] = sim_finedelayctrlin_falling_delay_1;
     dly_setting = 0;
     rising_dly  = 0;
     falling_dly = 0;
     tmp_dataout = 1'bx;
 end
 always @(delayctrlin_in or finedelayctrlin_in)
 begin
     if (use_delayctrlin == "false")
         dly_setting = delay_setting;
     else
         dly_setting = delayctrlin_in;
 	if (use_finedelayctrlin == "true")
    begin
 	    rising_dly  = dly_table_rising[dly_setting] + finedly_table_rising[finedelayctrlin_in];
 	    falling_dly = dly_table_falling[dly_setting] + finedly_table_falling[finedelayctrlin_in];
    end
 	else
    begin
 	    rising_dly  = dly_table_rising[dly_setting];
 	    falling_dly = dly_table_falling[dly_setting];
    end
 end
 always @(datain_in)
 begin
     if (datain_in === 1'b0)
         tmp_dataout <= #(falling_dly) datain_in;
     else
         tmp_dataout <= #(rising_dly) datain_in;
 end
 assign dataout = tmp_dataout;
 endmodule