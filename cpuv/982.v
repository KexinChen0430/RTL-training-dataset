module fifo_formalbench;
  wire reset = 1'b0;
  wire clock;
  wire enque, deque;
  wire [3:0] enque_data, deque_data, data0, data1, data2, data3;
  wire is_full, is_empty;
  fifo f0
    ( .reset
    , .clock
    , .enque
    , .deque
    , .enque_data
    , .deque_data
    , .enqued
    , .dequed
    , .is_full
    , .is_empty
    );
endmodule