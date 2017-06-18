<GameFile>
  <PropertyGroup Name="TetrisLoading" Type="Scene" ID="b1b8ac65-9a4c-4c6e-b580-f5a0b08d1cc5" Version="3.10.0.0" />
  <Content ctype="GameProjectContent">
    <Content>
      <Animation Duration="0" Speed="1.0000" />
      <ObjectData Name="Scene" Tag="24" ctype="GameNodeObjectData">
        <Size X="640.0000" Y="1136.0000" />
        <Children>
          <AbstractNodeData Name="panel" ActionTag="1918327196" Tag="34" IconVisible="False" TopMargin="0.0002" BottomMargin="-0.0002" ClipAble="False" ColorAngle="90.0000" LeftEage="131" RightEage="131" TopEage="288" BottomEage="288" Scale9OriginX="-131" Scale9OriginY="-288" Scale9Width="262" Scale9Height="576" ctype="PanelObjectData">
            <Size X="640.0000" Y="1136.0000" />
            <Children>
              <AbstractNodeData Name="bg" ActionTag="-355844809" Tag="138" IconVisible="False" LeftMargin="-106.0000" RightMargin="-106.0000" ctype="SpriteObjectData">
                <Size X="852.0000" Y="1136.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="320.0000" Y="568.0000" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.5000" Y="0.5000" />
                <PreSize X="1.3312" Y="1.0000" />
                <FileData Type="Normal" Path="ui/loading/loading_bg.png" Plist="" />
                <BlendFunc Src="770" Dst="771" />
              </AbstractNodeData>
              <AbstractNodeData Name="lb_tips" ActionTag="-546259228" Tag="4" IconVisible="False" LeftMargin="224.0000" RightMargin="224.0000" TopMargin="738.0975" BottomMargin="364.9025" FontSize="32" LabelText="正在登录游戏" ShadowOffsetX="1.0000" ShadowOffsetY="-1.0000" ShadowEnabled="True" ctype="TextObjectData">
                <Size X="192.0000" Y="33.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="320.0000" Y="381.4025" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.5000" Y="0.3357" />
                <PreSize X="0.3000" Y="0.0290" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="110" G="110" B="110" />
              </AbstractNodeData>
              <AbstractNodeData Name="progress" ActionTag="-344339417" Tag="94" IconVisible="False" LeftMargin="70.0000" RightMargin="70.0000" TopMargin="782.4342" BottomMargin="323.5658" TouchEnable="True" PercentInfo="50" ctype="SliderObjectData">
                <Size X="500.0000" Y="30.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="320.0000" Y="338.5658" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.5000" Y="0.2980" />
                <PreSize X="0.7813" Y="0.0264" />
                <BackGroundData Type="Normal" Path="ui/loading/loading_progress_bg.png" Plist="" />
                <ProgressBarData Type="Normal" Path="ui/loading/loading_progress.png" Plist="" />
                <BallNormalData Type="Default" Path="Default/SliderNode_Normal.png" Plist="" />
                <BallPressedData Type="Default" Path="Default/SliderNode_Press.png" Plist="" />
                <BallDisabledData Type="Default" Path="Default/SliderNode_Disable.png" Plist="" />
              </AbstractNodeData>
            </Children>
            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
            <Position X="320.0000" Y="567.9998" />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition X="0.5000" Y="0.5000" />
            <PreSize X="1.0000" Y="1.0000" />
            <SingleColor A="255" R="255" G="255" B="255" />
            <FirstColor A="255" R="150" G="200" B="255" />
            <EndColor A="255" R="255" G="255" B="255" />
            <ColorVector ScaleY="1.0000" />
          </AbstractNodeData>
        </Children>
      </ObjectData>
    </Content>
  </Content>
</GameFile>