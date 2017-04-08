<GameFile>
  <PropertyGroup Name="TetrisMeteorAnimation" Type="Scene" ID="af42ac34-7c12-4d9a-9f53-baad51340988" Version="3.10.0.0" />
  <Content ctype="GameProjectContent">
    <Content>
      <Animation Duration="12" Speed="0.1667">
        <Timeline ActionTag="-833199850" Property="Position">
          <PointFrame FrameIndex="0" X="0.0000" Y="0.0000">
            <EasingData Type="0" />
          </PointFrame>
          <PointFrame FrameIndex="9" X="0.0000" Y="0.0000">
            <EasingData Type="2" />
          </PointFrame>
          <PointFrame FrameIndex="12" X="0.0000" Y="0.0000">
            <EasingData Type="0" />
          </PointFrame>
        </Timeline>
        <Timeline ActionTag="-833199850" Property="Scale">
          <ScaleFrame FrameIndex="0" X="1.0000" Y="1.0000">
            <EasingData Type="0" />
          </ScaleFrame>
          <ScaleFrame FrameIndex="9" X="1.0000" Y="1.0000">
            <EasingData Type="2" />
          </ScaleFrame>
          <ScaleFrame FrameIndex="12" X="1.0000" Y="1.0000">
            <EasingData Type="0" />
          </ScaleFrame>
        </Timeline>
        <Timeline ActionTag="-833199850" Property="RotationSkew">
          <ScaleFrame FrameIndex="0" X="0.0000" Y="0.0000">
            <EasingData Type="0" />
          </ScaleFrame>
          <ScaleFrame FrameIndex="9" X="0.0000" Y="0.0000">
            <EasingData Type="2" />
          </ScaleFrame>
          <ScaleFrame FrameIndex="12" X="0.0000" Y="0.0000">
            <EasingData Type="0" />
          </ScaleFrame>
        </Timeline>
        <Timeline ActionTag="-833199850" Property="VisibleForFrame">
          <BoolFrame FrameIndex="0" Tween="False" Value="True" />
          <BoolFrame FrameIndex="9" Tween="False" Value="True" />
          <BoolFrame FrameIndex="12" Tween="False" Value="True" />
        </Timeline>
        <Timeline ActionTag="-833199850" Property="AnchorPoint">
          <ScaleFrame FrameIndex="0" X="0.0000" Y="0.0000">
            <EasingData Type="0" />
          </ScaleFrame>
          <ScaleFrame FrameIndex="12" X="0.0000" Y="0.0000">
            <EasingData Type="0" />
          </ScaleFrame>
        </Timeline>
        <Timeline ActionTag="-833199850" Property="Alpha">
          <IntFrame FrameIndex="0" Value="0">
            <EasingData Type="0" />
          </IntFrame>
          <IntFrame FrameIndex="9" Value="255">
            <EasingData Type="0" />
          </IntFrame>
          <IntFrame FrameIndex="12" Value="0">
            <EasingData Type="0" />
          </IntFrame>
        </Timeline>
      </Animation>
      <AnimationList>
        <AnimationInfo Name="yun" StartIndex="0" EndIndex="17">
          <RenderColor A="255" R="255" G="160" B="122" />
        </AnimationInfo>
      </AnimationList>
      <ObjectData Name="Scene" Tag="27" ctype="GameNodeObjectData">
        <Size X="640.0000" Y="1136.0000" />
        <Children>
          <AbstractNodeData Name="meteor2" ActionTag="-833199850" Alpha="28" Tag="106" IconVisible="False" RightMargin="614.0000" TopMargin="1110.0000" ctype="SpriteObjectData">
            <Size X="26.0000" Y="26.0000" />
            <AnchorPoint />
            <Position />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition />
            <PreSize X="0.0406" Y="0.0229" />
            <FileData Type="Normal" Path="ui/tetris/power/meteor2.png" Plist="" />
            <BlendFunc Src="1" Dst="771" />
          </AbstractNodeData>
        </Children>
      </ObjectData>
    </Content>
  </Content>
</GameFile>