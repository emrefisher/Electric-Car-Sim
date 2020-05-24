classdef EVGUI < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure             matlab.ui.Figure
        LowCoolantLampLabel  matlab.ui.control.Label
        LowCoolantLamp       matlab.ui.control.Lamp
        HighTempLampLabel    matlab.ui.control.Label
        HighTempLamp         matlab.ui.control.Lamp
        SpeedMPHGaugeLabel   matlab.ui.control.Label
        SpeedMPHGauge        matlab.ui.control.SemicircularGauge
        ButtonGroup          matlab.ui.container.ButtonGroup
        StartButton          matlab.ui.control.ToggleButton
        StopButton           matlab.ui.control.ToggleButton
        TireRPMGaugeLabel    matlab.ui.control.Label
        TireRPMGauge         matlab.ui.control.SemicircularGauge
        UIAxes               matlab.ui.control.UIAxes
        BatteryLabel         matlab.ui.control.Label
        BatteryGauge         matlab.ui.control.LinearGauge
    end

    methods (Access = private)

        % Callback function
        function AmplitudeSliderValueChanged(app, event)
         
        end
    end

    % App initialization and construction
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)
            ard=serial('/dev/cu.usbmodem14101','BaudRate',9600);
           % fopen(ard);
            %x = fscan(ard, '%f');
            %fprintf(x);
            
            
            Coolantlevel=1;
            Templevel=1;
            RPM = 100;
            MPH = RPM*60*4*pi/63360;
            time = [1:1:500];
            distance = RPM;

            % Create UIFigure
            app.UIFigure = uifigure;
            app.UIFigure.Position = [100 100 640 480];
            app.UIFigure.Name = 'UI Figure';

            % Create LowCoolantLampLabel
            app.LowCoolantLampLabel = uilabel(app.UIFigure);
            app.LowCoolantLampLabel.HorizontalAlignment = 'right';
            app.LowCoolantLampLabel.VerticalAlignment = 'top';
            app.LowCoolantLampLabel.Position = [57 170 74 15];
            app.LowCoolantLampLabel.Text = 'Low Coolant';

            % Create LowCoolantLamp
            app.LowCoolantLamp = uilamp(app.UIFigure);
            app.LowCoolantLamp.Enable = 'off';
            app.LowCoolantLamp.Position = [146 167 20 20];
            app.LowCoolantLamp.Color = [0 0.451 0.7412];
            if (Coolantlevel ==1)
                app.LowCoolantLamp.Enable = 'on';
            else
                app.LowCoolantLamp.Enable = 'off';
            end

            % Create HighTempLampLabel
            app.HighTempLampLabel = uilabel(app.UIFigure);
            app.HighTempLampLabel.HorizontalAlignment = 'right';
            app.HighTempLampLabel.VerticalAlignment = 'top';
            app.HighTempLampLabel.Position = [57 142 64 15];
            app.HighTempLampLabel.Text = 'High Temp';

            % Create HighTempLamp
            app.HighTempLamp = uilamp(app.UIFigure);
            app.HighTempLamp.Enable = 'off';
            app.HighTempLamp.Position = [146 139 20 20];
            app.HighTempLamp.Color = [1 0 0];
            if (Templevel ==1)
                app.HighTempLamp.Enable = 'on';
            else
                app.HighTempLamp.Enable = 'off';
            end

            % Create SpeedMPHGaugeLabel
            app.SpeedMPHGaugeLabel = uilabel(app.UIFigure);
            app.SpeedMPHGaugeLabel.HorizontalAlignment = 'center';
            app.SpeedMPHGaugeLabel.VerticalAlignment = 'top';
            app.SpeedMPHGaugeLabel.Position = [486.5 105 79 15];
            app.SpeedMPHGaugeLabel.Text = 'Speed (MPH)';

            % Create SpeedMPHGauge
            app.SpeedMPHGauge = uigauge(app.UIFigure, 'semicircular');
            app.SpeedMPHGauge.Position = [466 135 120 65];
            app.SpeedMPHGauge.Limits = [0 15]
            app.SpeedMPHGauge.Value = MPH;

            % Create ButtonGroup
            app.ButtonGroup = uibuttongroup(app.UIFigure);
            app.ButtonGroup.Position = [455 345 123 61];

            % Create StartButton
            app.StartButton = uitogglebutton(app.ButtonGroup);
            app.StartButton.Text = 'Start';
            app.StartButton.Position = [11 27 100 22];
            app.StartButton.Value = true;

            % Create StopButton
            app.StopButton = uitogglebutton(app.ButtonGroup);
            app.StopButton.Text = 'Stop';
            app.StopButton.Position = [11 6 100 22];

            % Create TireRPMGaugeLabel
            app.TireRPMGaugeLabel = uilabel(app.UIFigure);
            app.TireRPMGaugeLabel.HorizontalAlignment = 'center';
            app.TireRPMGaugeLabel.VerticalAlignment = 'top';
            app.TireRPMGaugeLabel.Position = [309.5 102 56 15];
            app.TireRPMGaugeLabel.Text = 'Tire RPM';

            % Create TireRPMGauge
            app.TireRPMGauge = uigauge(app.UIFigure, 'semicircular');
            app.TireRPMGauge.Position = [277 132 120 65];
            app.TireRPMGauge.Limits = [0 140];
            app.TireRPMGauge.Value = RPM;

            % Create UIAxes
            app.UIAxes = uiaxes(app.UIFigure);
            title(app.UIAxes, 'Distance Traveled')
            xlabel(app.UIAxes, 'Time')
            ylabel(app.UIAxes, 'Distane (Miles)')
            app.UIAxes.GridAlpha = 0.15;
            app.UIAxes.MinorGridAlpha = 0.25;
            app.UIAxes.Position = [57 230 315 217];
            app.UIAxes.XLim = [0 500];
            plot(app.UIAxes,distance, time);

            % Create BatteryLabel
            app.BatteryLabel = uilabel(app.UIFigure);
            app.BatteryLabel.HorizontalAlignment = 'center';
            app.BatteryLabel.VerticalAlignment = 'top';
            app.BatteryLabel.Position = [85.5 36 65 15];
            app.BatteryLabel.Text = 'Battery (%)';

            % Create BatteryGauge
            app.BatteryGauge = uigauge(app.UIFigure, 'linear');
            app.BatteryGauge.Position = [58 66 120 40];
            refresh;
        end
    end

    methods (Access = public)

        % Construct app
        function app = EVGUI
    while (1)
            % Create and configure components
            createComponents(app)
            pause(1);

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            if nargout == 0
                clear app
            end
    end
    %fclose(arduino) 
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            %delete(app.UIFigure)
        end
    end
end