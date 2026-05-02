function in = pidValidateResetFcn(in)
    % PID 验证环境重置函数
    % Reset function for PID validation environment
    %
    % 该函数被Simulink模型在验证阶段的每个episode开始时自动调用
    % This function is automatically called by Simulink at the beginning of each validation episode
    %
    % 用途: 使用固定的validationTemperature数据进行可重复的验证
    % Purpose: Use fixed validationTemperature data for reproducible validation
    
    % 从基础工作区读取验证温度数据
    data = evalin('base', 'validationTemperature');
    
    % 准备输入数据
    inputData = data;
    
    % 修改时间列为从0开始的秒数
    inputData(:, 1) = 60:60:60*size(inputData, 1);
    
    % 将处理后的数据写入基础工作区，供Simulink模型使用
    assignin('base', 'outsideTemperature', inputData);
end
