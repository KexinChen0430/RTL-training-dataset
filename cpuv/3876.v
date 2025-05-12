module i2c_master (
    Reset_i, Clk_i, F100_400_n_i, Divider800_i,
    StartProcess_i, ReceiveSend_n_i, Busy_o, ReadCount_i, FIFOReadNext_i,
    FIFOWrite_i, FIFOEmpty_o, FIFOFull_o, Data_i, Data_o, ErrAck_i,
    ErrBusColl_o, ErrFIFOFull_o, ErrGotNAck_o, ErrCoreBusy_o,
    ErrFIFOEmpty_o, ErrCoreStopped_o, ErrDevNotPresent_o,
    ErrReadCountZero_o, SDA_i, SDA_o, SCL_o, ScanEnable_i, ScanClk_i,
    ScanDataIn_i, ScanDataOut_o
);
    parameter ReadCountWidth_g = 4;          
    parameter FIFOAddressWidth_g = 4;        
    parameter DividerWidth_g = 16;           
    input [(DividerWidth_g-1):0] Divider800_i; 
    input [(ReadCountWidth_g-1):0] ReadCount_i; 
    input [7:0] Data_i;                        
    input Reset_i, Clk_i, F100_400_n_i, StartProcess_i, ReceiveSend_n_i,
          FIFOReadNext_i, FIFOWrite_i, ErrAck_i, SDA_i, ScanEnable_i, ScanClk_i,
          ScanDataIn_i;
    output [7:0] Data_o;                       
    output Busy_o, FIFOEmpty_o, FIFOFull_o, ErrBusColl_o, ErrFIFOFull_o,
           ErrGotNAck_o, ErrCoreBusy_o, ErrFIFOEmpty_o, ErrCoreStopped_o,
           ErrDevNotPresent_o, ErrReadCountZero_o, SDA_o, SCL_o, ScanDataOut_o;
endmodule