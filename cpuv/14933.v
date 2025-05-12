module 
    always @(posedge de_clk or negedge de_rstn)
        begin
            if (!de_rstn) set_sel    <= 0;
            else if (tc_ack) set_sel    <= {
                (ul1_hit | ul0_hit | lru_ul), 
                (ll1_hit | ll0_hit | lru_ll), 
                (ur1_hit | ur0_hit | lru_ur), 
                (lr1_hit | lr0_hit | lru_lr)  
            };
        end
    always @(posedge de_clk or negedge de_rstn)
        if (!de_rstn)
            set_read    <= 0;
        else if (tc_ack && exception)
            set_read    <= {
                (ul1_hit | (~ul0_hit & lru_ul)), 
                (ll1_hit | (~ll0_hit & lru_ll)), 
                (ul1_hit | (~ul0_hit & lru_ul)), 
                (ll1_hit | (~ll0_hit & lru_ll))  
            };
        else if (tc_ack && !exception)
            set_read    <= {
                (ul1_hit | (~ul0_hit & lru_ul)), 
                (ll1_hit | (~ll0_hit & lru_ll)), 
                (ur1_hit | (~ur0_hit & lru_ur)), 
                (lr1_hit | (~lr0_hit & lru_lr))  
            };
endmodule