<GameFile>
  <PropertyGroup Name="SliderTestScene" Type="Scene" ID="f53559b9-6386-4d80-89c3-b8f88cec690b" Version="3.10.0.0" />
  <Content ctype="GameProjectContent">
    <Content>
      <Animation Duration="0" Speed="1.0000" />
      <ObjectData Name="Scene" Tag="11" ctype="GameNodeObjectData">
        <Size X="640.0000" Y="1136.0000" />
        <Children>
          <AbstractNodeData Name="slider_bg" ActionTag="1474742195" Tag="12" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="243.0000" RightMargin="243.0000" TopMargin="290.0000" BottomMargin="290.0000" ctype="SpriteObjectData">
            <Size X="474.0000" Y="60.0000" />
            <Children>
              <AbstractNodeData Name="slider" ActionTag="-697369862" Tag="13" IconVisible="False" LeftMargin="81.0000" RightMargin="17.0000" TopMargin="21.0000" BottomMargin="21.0000" TouchEnable="True" PercentInfo="22" ctype="SliderObjectData">
                <Size X="376.0000" Y="18.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="269.0000" Y="30.0000" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.5675" Y="0.5000" />
                <PreSize X="0.7932" Y="0.3000" />
                <BackGroundData Type="Normal" Path="ui/slider/slider_2.png" Plist="" />
                <ProgressBarData Type="Normal" Path="ui/slider/slider_1.png" Plist="" />
                <BallNormalData Type="Normal" Path="ui/slider/slider.png" Plist="" />
                <BallPressedData Type="Normal" Path="ui/slider/slider.png" Plist="" />
                <BallDisabledData Type="Default" Path="Default/SliderNode_Disable.png" Plist="" />
              </AbstractNodeData>
            </Children>
            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
            <Position X="480.0000" Y="320.0000" />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition X="0.5000" Y="0.5000" />
            <PreSize X="0.4938" Y="0.0938" />
            <FileData Type="Normal" Path="ui/slider/slider_bg.png" Plist="" />
            <BlendFunc Src="1" Dst="771" />
          </AbstractNodeData>
          <AbstractNodeData Name="progress_title" ActionTag="-2048471171" Tag="14" IconVisible="False" LeftMargin="245.0000" RightMargin="571.0000" TopMargin="242.0000" BottomMargin="374.0000" FontSize="24" LabelText="滑动百分比：" ShadowOffsetX="1.0000" ShadowOffsetY="-1.0000" ShadowEnabled="True" ctype="TextObjectData">
            <Size X="144.0000" Y="24.0000" />
            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
            <Position X="317.0000" Y="386.0000" />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="0" G="128" B="0" />
            <PrePosition X="0.3302" Y="0.6031" />
            <PreSize X="0.1500" Y="0.0375" />
            <OutlineColor A="255" R="255" G="0" B="0" />
            <ShadowColor A="255" R="0" G="0" B="0" />
          </AbstractNodeData>
          <AbstractNodeData Name="progress_txt" ActionTag="507684644" Tag="15" IconVisible="False" LeftMargin="378.0000" RightMargin="546.0000" TopMargin="242.0000" BottomMargin="374.0000" FontSize="24" LabelText="100" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
            <Size X="36.0000" Y="24.0000" />
            <AnchorPoint ScaleX="0.7500" ScaleY="0.5417" />
            <Position X="405.0000" Y="387.0000" />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition X="0.4219" Y="0.6047" />
            <PreSize X="0.0375" Y="0.0375" />
            <OutlineColor A="255" R="255" G="0" B="0" />
            <ShadowColor A="255" R="110" G="110" B="110" />
          </AbstractNodeData>
        </Children>
      </ObjectData>
    </Content>
  </Content>
</GameFile>