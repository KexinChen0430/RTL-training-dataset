module tester(CLK,reset,cableReset_L,hardReset_L, message_received_for_Phy, CC_Busy, CC_Idle, Start, Unexpected_goodCRC, Tx_state_Machine, Data_from_I2C);
output reg CLK,reset,cableReset_L,hardReset_L,message_received_for_Phy, CC_Busy, CC_Idle, Start, Unexpected_goodCRC, Tx_state_Machine;
output reg [7:0] Data_from_I2C;
always #10 CLK = !CLK;
initial
  begin
    CLK <=0;
    reset <= 0;
    cableReset_L <=1;
    hardReset_L <=1;
    message_received_for_Phy <= 0;
    CC_Busy <= 0;
    CC_Idle <= 0;
    Start <= 0;
    Unexpected_goodCRC<=0;
    Tx_state_Machine <= 0;
    Data_from_I2C <= 4'b0000;
    $display("Inicia prueba #1, Estado Idle. Cable y Hard Reset en 1, Start en 0");
    #15;
    reset <= 1;
    Start<=1;
    #20;
    $display("Inicia prueba #2, Paso de estado Idle a Wait_for_Phy.");
    $display("Cable y Hard Reset en 1, Start en 1");
    #20;
    message_received_for_Phy =1;
    #2600 ;
    reset <=0;
    #20;
    reset <=1;
    Start<=1;
    message_received_for_Phy =1;
    Tx_state_Machine = 1;
    Unexpected_goodCRC = 1;
    #220 ;
    reset <=1;
    Start<=1;
    message_received_for_Phy =1;
    Tx_state_Machine = 1;
    Unexpected_goodCRC = 0;
    CC_Busy = 1;
    CC_Idle <= 0;
    #420 $finish;
  end
endmodule