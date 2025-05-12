module body
    always @(posedge clk)
        if(ena & deni)
            begin
                size <= #1 sizei;
                rlen <= #1 rleni;
                amp  <= #1 ampi;
            end
    always @(posedge clk)
        if(ena)
            begin
                sizeo <= #1 size;
                rleno <= #1 rlen;
                ampo  <= #1 amp;
                dc    <= #1 dci;
                dco   <= #1 dc;
            end
    assign zerobl = &rleni &  ~|sizei & deni;
    assign eob    = ~|{rleni, sizei} & deni & ~dci;
    always @(posedge clk or negedge rst)
        if (!rst)
            begin
                state <= #1 1'b0;
                den   <= #1 1'b0;
                deno  <= #1 1'b0;
            end
        else if(ena)
            case (state) 
                1'b0:
                    begin
                        if (zerobl)
                            begin
                                state <= #1 1'b1; 
                                den   <= #1 1'b0; 
                                deno  <= #1 den;  
                            end
                        else
                            begin
                                state <= #1 1'b0; 
                                den   <= #1 deni; 
                                deno  <= #1 den;  
                            end
                    end
                1'b1:
                    begin
                        deno <= #1 1'b0;
                        if (deni)
                            if (zerobl)
                                begin
                                    state <= #1 1'b1; 
                                    den   <= #1 1'b0; 
                                    deno  <= #1 1'b1; 
                                end
                            else if (eob)
                                begin
                                    state <= #1 1'b0; 
                                    den   <= #1 1'b1; 
                                    deno  <= #1 1'b0; 
                                end
                            else
                                begin
                                    state <= #1 1'b0; 
                                    den   <= #1 1'b1; 
                                    deno  <= #1 1'b1; 
                                end
                    end
            endcase
endmodule