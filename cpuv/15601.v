module fb_slave_statem (MRxClk, Reset, MRxDV, MRxDEq5, MRxDEqDataSoC, MRxDEqNumbSoC, MRxDEqDistSoC, MRxDEqDelaySoC, MRxDEqDelayDistSoC, SlaveIDStart, DelayMeasStart,
DistStateEnd, DelayDistStateEnd, SlaveDataStart, SlaveDataEnd, SlaveCrcEnd, IsLastSlave, DataFrameEnd, FrmCrcStateEnd,
StateIdle, StatePreamble, StateFFS, StateNumb, StateSlaveID, StateDist, StateDelay, StateDelayMeas, StateDelayDist, StateData, StateSlaveData,
StateSlaveCrc, StateFrmCrc
);