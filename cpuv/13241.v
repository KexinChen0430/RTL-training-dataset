module eth_txstatem  (MTxClk, Reset, ExcessiveDefer, CarrierSense, NibCnt, IPGT, IPGR1,
                      IPGR2, FullD, TxStartFrm, TxEndFrm, TxUnderRun, Collision, UnderRun,
                      StartTxDone, TooBig, NibCntEq7, NibCntEq15, MaxFrame, Pad, CrcEn,
                      NibbleMinFl, RandomEq0, ColWindow, RetryMax, NoBckof, RandomEqByteCnt,
                      StateIdle, StateIPG, StatePreamble, StateData, StatePAD, StateFCS,
                      StateJam, StateJam_q, StateBackOff, StateDefer, StartFCS, StartJam,
                      StartBackoff, StartDefer, DeferIndication, StartPreamble, StartData, StartIPG
                     );