module main ; 
event one_event ; 
always @(one_event)
      begin
          # 1; 
          $display("saw event"); 
      end
initial
    begin
     #1 ; 
     #1 ; 
     #1 ; 
     $finish ; 
    end
always -> one_event ; 
endmodule 