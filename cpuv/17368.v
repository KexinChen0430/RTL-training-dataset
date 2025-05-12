module
    PREEDGE <= `BSV_ASSIGNMENT_DELAY  (cntr == nexttick) ;
end
always@( posedge CLK_IN or `BSV_RESET_EDGE RST )
    begin
        if ( RST == `BSV_RESET_VALUE )
            cntr = upper - offset ;
        else
            begin
                if ( cntr < upper_w )
                    cntr = cntr + 1 ;
                else
                    cntr = lower_w ;
            end 
    end 
`ifdef BSV_NO_INITIAL_BLOCKS
`else 
    initial
        begin
            #0 ;
            cntr = (upper - offset)  ;
            PREEDGE = 0 ;
        end 
`endif 
endmodule