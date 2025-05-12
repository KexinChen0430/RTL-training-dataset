module would be just forwarding the signals 
  end else begin: gen_blk_1 
    assign data_o  = data[0]; 
    assign deque_o = deque_i; 
  end 
endmodule 