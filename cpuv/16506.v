module
always @(posedge CLK or negedge RESET_N)
begin
        if (RESET_N == 0)
        begin
                oe_shift <= 0;
                oe1      <= 0;
                oe2      <= 0;
                OE       <= 0;
        end
        else
        begin
                if (SC_PM == 0)
                begin
                        if (do_writea == 1)
                        begin
                                if (SC_BL == 1)             
                                        oe_shift <= 0;      
                                else if (SC_BL == 2)
                                        oe_shift <= 1;
                                else if (SC_BL == 4)
                                        oe_shift <= 7;
                                else if (SC_BL == 8)
                                        oe_shift <= 127;
                                oe1 <= 1;
                        end
                        else
                        begin
                                oe_shift <= (oe_shift>>1);
                                oe1  <= oe_shift[0];
                                oe2  <= oe1;
                                oe3  <= oe2;
                                oe4  <= oe3;
                                if (SC_RCD == 2)
                                        OE <= oe3;
                                else
                                        OE <= oe4;
                        end
                end
                else
                begin
                        if (do_writea == 1)                  
                                oe4   <= 1;
                        else if (do_precharge == 1 | do_reada == 1 | do_refresh==1 | do_initial == 1 | PM_STOP==1 )
                                oe4   <= 0;
                        OE <= oe4;
                end
        end
end
always @(posedge CLK or negedge RESET_N)
begin
        if (RESET_N == 0)
        begin
                rw_shift <= 0;
                do_rw    <= 0;
        end
        else
        begin
                if ((do_reada == 1) | (do_writea == 1))
                begin
                        if (SC_RCD == 1)                          
                                do_rw <= 1;
                        else if (SC_RCD == 2)
                                rw_shift <= 1;
                        else if (SC_RCD == 3)
                                rw_shift <= 2;
                end
                else
                begin
                        rw_shift <= (rw_shift>>1);
                        do_rw    <= rw_shift[0];
                end
        end
end
always @(posedge CLK or negedge RESET_N)
begin
        if (RESET_N == 0)
        begin
                CM_ACK   <= 0;
                REF_ACK  <= 0;
        end
        else
        begin
                if (do_refresh == 1 & REF_REQ == 1)                   
                        REF_ACK <= 1;
                else if ((do_refresh == 1) | (do_reada == 1) | (do_writea == 1) | (do_precharge == 1)   
                         | (do_load_mode))
                        CM_ACK <= 1;
                else
                begin
                        REF_ACK <= 0;
                        CM_ACK  <= 0;
                end
        end
end
always @(posedge CLK ) begin
        if (RESET_N==0) begin
                SA    <= 0;
                BA    <= 0;
                CS_N  <= 1;
                RAS_N <= 1;
                CAS_N <= 1;
                WE_N  <= 1;
                CKE   <= 0;
        end
        else begin
                CKE <= 1;
                if (do_writea == 1 | do_reada == 1)    
                        SA <= rowaddr;
                else
                        SA <= coladdr;                 
                if ((do_rw==1) | (do_precharge))
                        SA[10] <= !SC_PM;              
                if (do_precharge==1 | do_load_mode==1)
                        BA <= 0;                       
                else
                        BA <= bankaddr[1:0];           
                if (do_refresh==1 | do_precharge==1 | do_load_mode==1 | do_initial==1)
                        CS_N <= 0;                                    
                else                                                  
                begin
                        CS_N[0] <= SADDR[`ASIZE-1];                   
                        CS_N[1] <= ~SADDR[`ASIZE-1];                  
                end
                if(do_load_mode==1)
                SA    <= {2'b00,SDR_CL,SDR_BT,SDR_BL};
                if ( do_refresh==1 ) begin                        
                        RAS_N <= 0;
                        CAS_N <= 0;
                        WE_N  <= 1;
                end
                else if ((do_precharge==1) & ((oe4 == 1) | (rw_flag == 1))) begin      
                        RAS_N <= 1;
                        CAS_N <= 1;
                        WE_N  <= 0;
                end
                else if (do_precharge==1) begin                 
                        RAS_N <= 0;
                        CAS_N <= 1;
                        WE_N  <= 0;
                end
                else if (do_load_mode==1) begin                 
                        RAS_N <= 0;
                        CAS_N <= 0;
                        WE_N  <= 0;
                end
                else if (do_reada == 1 | do_writea == 1) begin  
                        RAS_N <= 0;
                        CAS_N <= 1;
                        WE_N  <= 1;
                end
                else if (do_rw == 1) begin                      
                        RAS_N <= 1;
                        CAS_N <= 0;
                        WE_N  <= rw_flag;
                end
                else if (do_initial ==1) begin
                        RAS_N <= 1;
                        CAS_N <= 1;
                        WE_N  <= 1;
                end
                else begin                                      
                        RAS_N <= 1;
                        CAS_N <= 1;
                        WE_N  <= 1;
                end
        end
end
endmodule