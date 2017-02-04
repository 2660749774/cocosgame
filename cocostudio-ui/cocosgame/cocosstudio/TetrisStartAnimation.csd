<GameFile>
  <PropertyGroup Name="TetrisStartAnimation" Type="Scene" ID="28a5f935-cf07-46df-8d22-fccc77c6e21c" Version="3.10.0.0" />
  <Content ctype="GameProjectContent">
    <Content>
      <Animation Duration="17" Speed="0.1667">
        <Timeline ActionTag="-1848402198" Property="Position">
          <PointFrame FrameIndex="0" X="-213.0000" Y="568.0000">
            <EasingData Type="0" />
          </PointFrame>
          <PointFrame FrameIndex="2" X="324.0019" Y="567.9999">
            <EasingData Type="0" />
          </PointFrame>
          <PointFrame FrameIndex="7" X="324.0000" Y="568.0000">
            <EasingData Type="0" />
          </PointFrame>
          <PointFrame FrameIndex="17" X="-320.0000" Y="568.0000">
            <EasingData Type="0" />
          </PointFrame>
        </Timeline>
        <Timeline ActionTag="-1848402198" Property="Scale">
          <ScaleFrame FrameIndex="0" X="1.0000" Y="1.0000">
            <EasingData Type="0" />
          </ScaleFrame>
          <ScaleFrame FrameIndex="2" X="1.0000" Y="1.0000">
            <EasingData Type="0" />
          </ScaleFrame>
          <ScaleFrame FrameIndex="7" X="1.0000" Y="1.0000">
            <EasingData Type="0" />
          </ScaleFrame>
          <ScaleFrame FrameIndex="17" X="1.0000" Y="1.0000">
            <EasingData Type="0" />
          </ScaleFrame>
        </Timeline>
        <Timeline ActionTag="-1848402198" Property="RotationSkew">
          <ScaleFrame FrameIndex="0" X="0.0000" Y="0.0000">
            <EasingData Type="0" />
          </ScaleFrame>
          <ScaleFrame FrameIndex="2" X="0.0000" Y="0.0000">
            <EasingData Type="0" />
          </ScaleFrame>
          <ScaleFrame FrameIndex="7" X="0.0000" Y="0.0000">
            <EasingData Type="0" />
          </ScaleFrame>
          <ScaleFrame FrameIndex="17" X="0.0000" Y="0.0000">
            <EasingData Type="0" />
          </ScaleFrame>
        </Timeline>
        <Timeline ActionTag="-1848402198" Property="FrameEvent">
          <EventFrame FrameIndex="5" Tween="False" Value="loadNext" />
        </Timeline>
        <Timeline ActionTag="2111664177" Property="Position">
          <PointFrame FrameIndex="0" X="852.0000" Y="568.0000">
            <EasingData Type="0" />
          </PointFrame>
          <PointFrame FrameIndex="2" X="318.0015" Y="567.9999">
            <EasingData Type="0" />
          </PointFrame>
          <PointFrame FrameIndex="7" X="328.0000" Y="568.0000">
            <EasingData Type="0" />
          </PointFrame>
          <PointFrame FrameIndex="17" X="1031.0007" Y="567.9999">
            <EasingData Type="0" />
          </PointFrame>
        </Timeline>
        <Timeline ActionTag="2111664177" Property="Scale">
          <ScaleFrame FrameIndex="0" X="1.0000" Y="1.0000">
            <EasingData Type="0" />
          </ScaleFrame>
          <ScaleFrame FrameIndex="2" X="1.0000" Y="1.0000">
            <EasingData Type="0" />
          </ScaleFrame>
          <ScaleFrame FrameIndex="7" X="1.0000" Y="1.0000">
            <EasingData Type="0" />
          </ScaleFrame>
          <ScaleFrame FrameIndex="17" X="1.0000" Y="1.0000">
            <EasingData Type="0" />
          </ScaleFrame>
        </Timeline>
        <Timeline ActionTag="2111664177" Property="RotationSkew">
          <ScaleFrame FrameIndex="0" X="0.0000" Y="0.0000">
            <EasingData Type="0" />
          </ScaleFrame>
          <ScaleFrame FrameIndex="2" X="0.0000" Y="0.0000">
            <EasingData Type="0" />
          </ScaleFrame>
          <ScaleFrame FrameIndex="7" X="0.0000" Y="0.0000">
            <EasingData Type="0" />
          </ScaleFrame>
          <ScaleFrame FrameIndex="17" X="0.0000" Y="0.0000">
            <EasingData Type="0" />
          </ScaleFrame>
        </Timeline>
      </Animation>
      <AnimationList>
        <AnimationInfo Name="yun" StartIndex="0" EndIndex="17">
          <RenderColor A="255" R="255" G="160" B="122" />
        </AnimationInfo>
      </AnimationList>
      <ObjectData Name="Scene" Tag="27" ctype="GameNodeObjectData">
        <Size X="1136.0000" Y="640.0000" />
        <Children>
          <AbstractNodeData Name="panel" ActionTag="574730510" Tag="27" IconVisible="False" TouchEnable="True" ClipAble="False" BackColorAlpha="0" ComboBoxIndex="1" ColorAngle="90.0000" Scale9Width="1" Scale9Height="1" ctype="PanelObjectData">
            <Size X="640.0000" Y="1136.0000" />
            <Children>
              <AbstractNodeData Name="yun_left" ActionTag="-1848402198" Tag="28" IconVisible="False" LeftMargin="-101.9981" RightMargin="-110.0019" TopMargin="0.0001" BottomMargin="-0.0001" ctype="SpriteObjectData">
                <Size X="852.0000" Y="1136.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="324.0019" Y="567.9999" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.5063" Y="0.5000" />
                <PreSize X="1.3312" Y="1.0000" />
                <FileData Type="Normal" Path="ui/tetris/yun_left.png" Plist="" />
                <BlendFunc Src="1" Dst="771" />
              </AbstractNodeData>
              <AbstractNodeData Name="yun_right" ActionTag="2111664177" Tag="29" IconVisible="False" LeftMargin="-107.9985" RightMargin="-104.0015" TopMargin="0.0001" BottomMargin="-0.0001" ctype="SpriteObjectData">
                <Size X="852.0000" Y="1136.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="318.0015" Y="567.9999" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.4969" Y="0.5000" />
                <PreSize X="1.3312" Y="1.0000" />
                <FileData Type="Normal" Path="ui/tetris/yun_right.png" Plist="" />
                <BlendFunc Src="1" Dst="771" />
              </AbstractNodeData>
            </Children>
            <AnchorPoint />
            <Position />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition />
            <PreSize X="1.0000" Y="1.0000" />
            <SingleColor A="255" R="150" G="200" B="255" />
            <FirstColor A="255" R="150" G="200" B="255" />
            <EndColor A="255" R="255" G="255" B="255" />
            <ColorVector ScaleY="1.0000" />
          </AbstractNodeData>
          <AbstractNodeData Name="Panel_2" ActionTag="-400182828" VisibleForFrame="False" Tag="28" IconVisible="False" LeftMargin="-103.9999" RightMargin="-108.0001" TouchEnable="True" ClipAble="False" BackColorAlpha="95" ComboBoxIndex="1" ColorAngle="90.0000" Scale9Width="1" Scale9Height="1" ctype="PanelObjectData">
            <Size X="852.0000" Y="1136.0000" />
            <AnchorPoint />
            <Position X="-103.9999" />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition X="-0.1625" />
            <PreSize X="1.3312" Y="1.0000" />
            <SingleColor A="255" R="255" G="0" B="0" />
            <FirstColor A="255" R="150" G="200" B="255" />
            <EndColor A="255" R="255" G="255" B="255" />
            <ColorVector ScaleY="1.0000" />
          </AbstractNodeData>
        </Children>
      </ObjectData>
    </Content>
  </Content>
</GameFile>