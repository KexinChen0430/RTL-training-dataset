module fanout
  #(parameter int N = 1) 
   (
    intf upstream, 
    intf downstream[N-1:0] 
    );
   genvar         i; 
   for (i = 0; i < N; i = i + 1) 
     assign downstream[i].value = upstream.value; 
endmodule 