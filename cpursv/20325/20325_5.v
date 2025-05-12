
module definition;

  
  always @(*)
      begin
        list_get_entry_valid = list_v[0];
        list_get_entry_id = list[0];
        list_get_entry_id_vector = list_vector;
        list_put_entry_ready = ~list_v[(-1)+CTL_LIST_DEPTH];
      end
  integer i;

  
  always @(posedge ctl_clk or negedge ctl_reset_n)
      begin
        if (~ctl_reset_n) 
          begin
            for (i = 0; i < CTL_LIST_DEPTH; i = i+1'b1)
                begin
                  if (CTL_LIST_INIT_VALUE_TYPE == INCR) 
                    begin
                      list[i] <= i;
                    end
                  else 
                    begin
                      list[i] <= {CTL_LIST_WIDTH{1'b0}};
                    end
                  if (CTL_LIST_INIT_VALID == VALID) 
                    begin
                      list_v[i] <= 1'b1;
                    end
                  else 
                    begin
                      list_v[i] <= 1'b0;
                    end
                end
            list_vector <= {CTL_LIST_DEPTH{1'b0}};
          end
        else 
          begin
            if (list_get) 
              begin
                for (i = 1; i < CTL_LIST_DEPTH; i = i+1'b1)
                    begin
                      list_v[i-1] <= list_v[i];
                      list[i-1] <= list[i];
                    end
                list_v[(-1)+CTL_LIST_DEPTH] <= 0;
                for (i = 0; i < CTL_LIST_DEPTH; i = i+1'b1)
                    begin
                      list_vector[i] <= (i == list[1]) ? 1'b1 : 1'b0;
                    end
              end
              
            if (list_put) 
              begin
                if (~list_get) 
                  begin
                    for (i = 1; i < CTL_LIST_DEPTH; i = i+1'b1)
                        begin
                          if (~list_v[i] & list_v[i-1]) 
                            begin
                              list_v[i] <= 1'b1;
                              list[i] <= list_put_entry_id;
                            end
                            
                        end
                    if (~list_v[0]) 
                      begin
                        list_v[0] <= 1'b1;
                        list[0] <= list_put_entry_id;
                        for (i = 0; i < CTL_LIST_DEPTH; i = i+1'b1)
                            begin
                              list_vector[i] <= (i == list_put_entry_id) ? 1'b1 : 1'b0;
                            end
                      end
                      
                  end
                else 
                  begin
                    for (i = 1; i < CTL_LIST_DEPTH; i = i+1'b1)
                        begin
                          if (~list_v[i] & list_v[i-1]) 
                            begin
                              list_v[i-1] <= 1'b1;
                              list[i-1] <= list_put_entry_id;
                            end
                            
                        end
                    for (i = 0; i < CTL_LIST_DEPTH; i = i+1'b1)
                        begin
                          if (list_v[0] & ~list_v[1]) 
                            begin
                              list_vector[i] <= (i == list_put_entry_id) ? 1'b1 : 1'b0;
                            end
                          else 
                            begin
                              list_vector[i] <= (i == list[1]) ? 1'b1 : 1'b0;
                            end
                        end
                  end
              end
              
          end
      end
endmodule

