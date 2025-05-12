module bw_u1_ckbuf_1p5x  (clk, rclk); 
    buf (clk, rclk); 
    initial begin 
        if ($time > (4* 1)) begin 
            $display ("MILSTATE", 
                      "Error: SPARC/IFU/MILFSM: unknown state! %b\n",milstate); 
        end
    end
endmodule 