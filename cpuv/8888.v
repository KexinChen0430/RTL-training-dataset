module.
  assign 	ff_stp = left_pinl;
  assign 	ff_rls  = xr_start ;
  always  @*
    if (!vsync) begin
      refr_state_next = DC_START;  
      pinl_count_next[9:0] = (rsuppr & ~(|ovtl_y))? left_pinl: 
                             pinl_regist[9:0];              
      lstat_next= (rsuppr & ~(|ovtl_y))? 2'b10: 2'b11;
      mcdcx_next=10'b0;
      mcdcy_next=12'b0;
      linfr_count_next = 12'b0;
      zcount_next[3:0]=dzoom_regist[3:0];
    end else begin
      case (refr_state) 
	DC_START:   begin
          if(  (pinl_count == 10'b0)
               ||(vactive_regist==12'b0) 
               ||(!refresh_enable_regist)
               )
            refr_state_next = DC_IDLE;
          else
            refr_state_next = DC_WAIT_FOR_TRANSFER;
          pinl_count_next[9:0] = pinl_count[9:0];
          lstat_next=lstat;
          linfr_count_next=linfr_count;
          zcount_next=zcount;
          mcdcx_next=10'b0;
          mcdcy_next=12'b0;
        end
	DC_WAIT_FOR_TRANSFER:
          if(mcdc_req) begin
            refr_state_next = DC_TRANSFER_DONE;
            if(pinl_count[9:0] == preq[5:0])
            begin
              linfr_count_next=incrlc ;
              case (lstat)  
                2'b00,
                2'b11: 
                  if (lstf && rsuppr) begin 
                    lstat_next=2'b10;
                    pinl_count_next = left_pinl; end
                  else begin                
                    lstat_next=2'b11;
                    pinl_count_next = pinl_regist; end
                2'b10: 
                  begin                
                    lstat_next=2'b01;
                    pinl_count_next = right_pinl; end
                2'b01: 
                  if (lstr ) begin         
                    lstat_next=2'b11;
                    pinl_count_next = pinl_regist; end
                  else begin               
                    lstat_next=2'b10;
                    pinl_count_next = left_pinl; end
              endcase
              if(lstat==2'b10)     
              begin
                mcdcx_next=xr_start;
                mcdcy_next= mcdcy;
                zcount_next=zcount; end
              else              
              begin
                mcdcx_next=10'b0;
                if(zcount==4'b0)
                begin
                  mcdcy_next= mcdcy + 1'b1;
                  zcount_next=dzoom_regist; end
                else begin
                  mcdcy_next= mcdcy;
                  zcount_next=zcount - 1'b1; end
              end
            end
            else begin 
              pinl_count_next[9:0] = pinl_count[9:0] - preq[5:0];
              lstat_next=lstat;
              mcdcx_next=mcdcx + preq[5:0];
              mcdcy_next= mcdcy;
              zcount_next=zcount;
              linfr_count_next=linfr_count; end
          end else begin 
            refr_state_next = refr_state;
            pinl_count_next[9:0] = pinl_count[9:0] ;
            lstat_next=lstat;
            mcdcx_next=mcdcx;
            mcdcy_next= mcdcy;
            zcount_next=zcount;
            linfr_count_next=linfr_count;
	  end
	DC_TRANSFER_DONE:           
          begin
            if (linfr_count==linfr_total) 
              refr_state_next = DC_IDLE;
            else
              refr_state_next = DC_WAIT_FOR_TRANSFER;
            pinl_count_next = pinl_count ;
            lstat_next=lstat;
            mcdcx_next=mcdcx;
            mcdcy_next= mcdcy;
            zcount_next=zcount;
            linfr_count_next=linfr_count;
          end
	DC_IDLE:    begin
          refr_state_next = refr_state; 
          mcdcx_next=mcdcx;
          mcdcy_next= mcdcy;
          zcount_next=zcount;
          linfr_count_next=linfr_count;
          pinl_count_next = pinl_count ;
          lstat_next=lstat;
        end
      endcase
    end
  always @(posedge pixclock or negedge hnreset)
    if(!hnreset) begin
      refr_state  <= DC_IDLE;
      mcdcx       <= 10'b0;
      mcdcy       <= 12'b0;
      zcount      <= 4'b0;
      pinl_count  <= 10'b0;
      lstat       <= 2'b0;
      linfr_count <= 12'b0;
      rsuppre     <= 1'b0;
      suppr16up   <= 1'b0;
    end else if(!dcnreset && crtclock) begin
      refr_state  <= DC_IDLE;
      mcdcx       <= 10'b0;
      mcdcy       <= 12'b0;
      zcount      <= 4'b0;
      pinl_count  <= 10'b0;
      lstat       <= 2'b0;
      linfr_count <= 12'b0;
      rsuppre     <= 1'b0;
      suppr16up   <= 1'b0;
    end else if (crtclock) begin
      refr_state  <= refr_state_next;
      mcdcx       <= mcdcx_next;
      mcdcy       <= mcdcy_next;
      zcount      <= zcount_next;
      pinl_count  <= pinl_count_next;
      lstat       <= lstat_next;
      linfr_count <= linfr_count_next;
      rsuppre     <= (ovnokey & ~ovignr_regist);
      suppr16up   <= ovignr16l_regist;
    end
endmodule