<GameFile>
  <PropertyGroup Name="TetrisPointAnimation1" Type="Scene" ID="99d313f7-c896-4c0a-ac7a-bd4f9a52d68a" Version="3.10.0.0" />
  <Content ctype="GameProjectContent">
    <Content>
      <Animation Duration="30" Speed="0.2500">
        <Timeline ActionTag="-1025733822" Property="Position">
          <PointFrame FrameIndex="0" X="55.0000" Y="55.0000">
            <EasingData Type="0" />
          </PointFrame>
          <PointFrame FrameIndex="20" X="55.0000" Y="55.0000">
            <EasingData Type="0" />
          </PointFrame>
          <PointFrame FrameIndex="30" X="55.0000" Y="55.0000">
            <EasingData Type="0" />
          </PointFrame>
        </Timeline>
        <Timeline ActionTag="-1025733822" Property="Scale">
          <ScaleFrame FrameIndex="0" X="1.0000" Y="1.0000">
            <EasingData Type="0" />
          </ScaleFrame>
          <ScaleFrame FrameIndex="20" X="1.2000" Y="1.2000">
            <EasingData Type="0" />
          </ScaleFrame>
          <ScaleFrame FrameIndex="30" X="1.0000" Y="1.0000">
            <EasingData Type="0" />
          </ScaleFrame>
        </Timeline>
        <Timeline ActionTag="-1025733822" Property="RotationSkew">
          <ScaleFrame FrameIndex="0" X="0.0000" Y="0.0000">
            <EasingData Type="0" />
          </ScaleFrame>
          <ScaleFrame FrameIndex="20" X="0.0000" Y="0.0000">
            <EasingData Type="0" />
          </ScaleFrame>
          <ScaleFrame FrameIndex="30" X="0.0000" Y="0.0000">
            <EasingData Type="0" />
          </ScaleFrame>
        </Timeline>
        <Timeline ActionTag="-1025733822" Property="FileData">
          <TextureFrame FrameIndex="20" Tween="False">
            <TextureFile Type="Normal" Path="animation/attacking/attack.png" Plist="" />
          </TextureFrame>
        </Timeline>
        <Timeline ActionTag="-1025733822" Property="BlendFunc">
          <BlendFuncFrame FrameIndex="20" Tween="False" Src="1" Dst="771" />
        </Timeline>
      </Animation>
      <ObjectData Name="Scene" Tag="24" ctype="GameNodeObjectData">
        <Size X="640.0000" Y="1136.0000" />
        <Children>
          <AbstractNodeData Name="panel" ActionTag="1918327196" Tag="34" IconVisible="False" LeftMargin="-100.0000" RightMargin="540.0000" TopMargin="1036.0000" BottomMargin="-100.0000" ClipAble="False" ColorAngle="90.0000" LeftEage="131" RightEage="131" TopEage="288" BottomEage="288" Scale9OriginX="-131" Scale9OriginY="-288" Scale9Width="262" Scale9Height="576" ctype="PanelObjectData">
            <Size X="200.0000" Y="200.0000" />
            <Children>
              <AbstractNodeData Name="attack" ActionTag="-1025733822" Tag="191" IconVisible="False" LeftMargin="-45.0000" RightMargin="45.0000" TopMargin="45.0000" BottomMargin="-45.0000" ctype="SpriteObjectData">
                <Size X="200.0000" Y="200.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="55.0000" Y="55.0000" />
                <Scale ScaleX="1.0700" ScaleY="1.0700" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.2750" Y="0.2750" />
                <PreSize X="1.0000" Y="1.0000" />
                <FileData Type="Normal" Path="animation/attacking/attack.png" Plist="" />
                <BlendFunc Src="1" Dst="771" />
              </AbstractNodeData>
            </Children>
            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
            <Position />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition />
            <PreSize X="0.3125" Y="0.1761" />
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