<GameFile>
  <PropertyGroup Name="TetrisStart" Type="Scene" ID="ef74ddda-9c92-46af-a572-b39a14ac9736" Version="3.10.0.0" />
  <Content ctype="GameProjectContent">
    <Content>
      <Animation Duration="60" Speed="0.5000">
        <Timeline ActionTag="1707810620" Property="Position">
          <PointFrame FrameIndex="0" X="254.0000" Y="480.0000">
            <EasingData Type="0" />
          </PointFrame>
          <PointFrame FrameIndex="60" X="254.0000" Y="480.0000">
            <EasingData Type="0" />
          </PointFrame>
        </Timeline>
        <Timeline ActionTag="1707810620" Property="Scale">
          <ScaleFrame FrameIndex="0" X="1.0000" Y="1.0000">
            <EasingData Type="0" />
          </ScaleFrame>
          <ScaleFrame FrameIndex="60" X="1.0000" Y="1.0000">
            <EasingData Type="0" />
          </ScaleFrame>
        </Timeline>
        <Timeline ActionTag="1707810620" Property="RotationSkew">
          <ScaleFrame FrameIndex="0" X="0.0000" Y="0.0000">
            <EasingData Type="0" />
          </ScaleFrame>
          <ScaleFrame FrameIndex="60" X="-360.0000" Y="-360.0000">
            <EasingData Type="0" />
          </ScaleFrame>
        </Timeline>
        <Timeline ActionTag="1384666103" Property="Position">
          <PointFrame FrameIndex="0" X="394.0000" Y="402.0038">
            <EasingData Type="0" />
          </PointFrame>
          <PointFrame FrameIndex="60" X="394.0000" Y="402.0038">
            <EasingData Type="0" />
          </PointFrame>
        </Timeline>
        <Timeline ActionTag="1384666103" Property="Scale">
          <ScaleFrame FrameIndex="60" X="1.0000" Y="1.0000">
            <EasingData Type="0" />
          </ScaleFrame>
        </Timeline>
        <Timeline ActionTag="1384666103" Property="RotationSkew">
          <ScaleFrame FrameIndex="0" X="0.0000" Y="0.0000">
            <EasingData Type="0" />
          </ScaleFrame>
          <ScaleFrame FrameIndex="60" X="360.0000" Y="360.0000">
            <EasingData Type="0" />
          </ScaleFrame>
        </Timeline>
        <Timeline ActionTag="-1178541226" Property="Position">
          <PointFrame FrameIndex="7" X="320.0000" Y="287.0004">
            <EasingData Type="0" />
          </PointFrame>
        </Timeline>
      </Animation>
      <ObjectData Name="Scene" Tag="24" ctype="GameNodeObjectData">
        <Size X="640.0000" Y="1136.0000" />
        <Children>
          <AbstractNodeData Name="panel" ActionTag="1918327196" Tag="34" IconVisible="False" TopMargin="0.0002" BottomMargin="-0.0002" ClipAble="False" ColorAngle="90.0000" LeftEage="131" RightEage="131" TopEage="288" BottomEage="288" Scale9OriginX="-131" Scale9OriginY="-288" Scale9Width="262" Scale9Height="576" ctype="PanelObjectData">
            <Size X="640.0000" Y="1136.0000" />
            <Children>
              <AbstractNodeData Name="bg" ActionTag="-355844809" Tag="138" IconVisible="False" LeftMargin="-105.0000" RightMargin="-105.0000" ctype="SpriteObjectData">
                <Size X="850.0000" Y="1136.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="320.0000" Y="568.0000" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.5000" Y="0.5000" />
                <PreSize X="1.3281" Y="1.0000" />
                <FileData Type="Normal" Path="ui/bg/pvp_bg.png" Plist="" />
                <BlendFunc Src="770" Dst="771" />
              </AbstractNodeData>
              <AbstractNodeData Name="gear" ActionTag="1707810620" Tag="102" RotationSkewX="-312.0000" RotationSkewY="-312.0000" IconVisible="False" LeftMargin="168.0000" RightMargin="300.0000" TopMargin="570.0000" BottomMargin="394.0000" ctype="SpriteObjectData">
                <Size X="172.0000" Y="172.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="254.0000" Y="480.0000" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.3969" Y="0.4225" />
                <PreSize X="0.2688" Y="0.1514" />
                <FileData Type="Normal" Path="ui/login/gear.png" Plist="" />
                <BlendFunc Src="1" Dst="771" />
              </AbstractNodeData>
              <AbstractNodeData Name="content" ActionTag="-571509939" VisibleForFrame="False" Tag="104" IconVisible="False" LeftMargin="168.0000" RightMargin="300.0000" TopMargin="570.0000" BottomMargin="394.0000" TouchEnable="True" ClipAble="False" BackColorAlpha="102" ColorAngle="90.0000" ctype="PanelObjectData">
                <Size X="172.0000" Y="172.0000" />
                <Children>
                  <AbstractNodeData Name="time_bg_5" ActionTag="88024854" Tag="105" IconVisible="False" LeftMargin="66.2241" RightMargin="61.7759" TopMargin="42.0769" BottomMargin="85.9231" ctype="SpriteObjectData">
                    <Size X="44.0000" Y="44.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="88.2241" Y="107.9231" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition X="0.5129" Y="0.6275" />
                    <PreSize X="0.2558" Y="0.2558" />
                    <FileData Type="PlistSubImage" Path="time_bg.png" Plist="ui/plist/common.plist" />
                    <BlendFunc Src="1" Dst="771" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="time_bg_5_0" ActionTag="340596108" Tag="106" IconVisible="False" LeftMargin="40.8866" RightMargin="87.1134" TopMargin="75.6181" BottomMargin="52.3819" ctype="SpriteObjectData">
                    <Size X="44.0000" Y="44.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="62.8866" Y="74.3819" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition X="0.3656" Y="0.4325" />
                    <PreSize X="0.2558" Y="0.2558" />
                    <FileData Type="PlistSubImage" Path="time_bg.png" Plist="ui/plist/common.plist" />
                    <BlendFunc Src="1" Dst="771" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="time_bg_5_1" ActionTag="1452074543" Tag="107" IconVisible="False" LeftMargin="80.5426" RightMargin="47.4574" TopMargin="79.1091" BottomMargin="48.8909" ctype="SpriteObjectData">
                    <Size X="44.0000" Y="44.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="102.5426" Y="70.8909" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition X="0.5962" Y="0.4122" />
                    <PreSize X="0.2558" Y="0.2558" />
                    <FileData Type="PlistSubImage" Path="time_bg.png" Plist="ui/plist/common.plist" />
                    <BlendFunc Src="1" Dst="771" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="score_bg_9" ActionTag="2103541177" Tag="109" IconVisible="False" LeftMargin="65.0000" RightMargin="63.0000" TopMargin="67.0000" BottomMargin="69.0000" ctype="SpriteObjectData">
                    <Size X="44.0000" Y="36.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="87.0000" Y="87.0000" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition X="0.5058" Y="0.5058" />
                    <PreSize X="0.2558" Y="0.2093" />
                    <FileData Type="PlistSubImage" Path="score_bg.png" Plist="ui/plist/common.plist" />
                    <BlendFunc Src="1" Dst="771" />
                  </AbstractNodeData>
                </Children>
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="254.0000" Y="480.0000" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.3969" Y="0.4225" />
                <PreSize X="0.2688" Y="0.1514" />
                <SingleColor A="255" R="150" G="200" B="255" />
                <FirstColor A="255" R="150" G="200" B="255" />
                <EndColor A="255" R="255" G="255" B="255" />
                <ColorVector ScaleY="1.0000" />
              </AbstractNodeData>
              <AbstractNodeData Name="content_0" ActionTag="-1151910964" Tag="124" IconVisible="False" LeftMargin="157.0000" RightMargin="289.0000" TopMargin="559.0000" BottomMargin="383.0000" TouchEnable="True" ClipAble="False" BackColorAlpha="102" ColorAngle="90.0000" Scale9Width="1" Scale9Height="1" ctype="PanelObjectData">
                <Size X="194.0000" Y="194.0000" />
                <Children>
                  <AbstractNodeData Name="fangkuai" ActionTag="-746237621" Tag="125" IconVisible="False" LeftMargin="53.9998" RightMargin="114.0002" TopMargin="72.0001" BottomMargin="95.9999" ctype="SpriteObjectData">
                    <Size X="26.0000" Y="26.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="66.9998" Y="108.9999" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition X="0.3454" Y="0.5619" />
                    <PreSize X="0.1340" Y="0.1340" />
                    <FileData Type="PlistSubImage" Path="fangkuai.png" Plist="ui/plist/common.plist" />
                    <BlendFunc Src="1" Dst="771" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="fangkuai_0" ActionTag="71707415" Tag="126" IconVisible="False" LeftMargin="80.9996" RightMargin="87.0004" TopMargin="72.0001" BottomMargin="95.9999" ctype="SpriteObjectData">
                    <Size X="26.0000" Y="26.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="93.9996" Y="108.9999" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition X="0.4845" Y="0.5619" />
                    <PreSize X="0.1340" Y="0.1340" />
                    <FileData Type="PlistSubImage" Path="fangkuai.png" Plist="ui/plist/common.plist" />
                    <BlendFunc Src="1" Dst="771" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="fangkuai_1" ActionTag="-1361295778" Tag="127" IconVisible="False" LeftMargin="80.9996" RightMargin="87.0004" TopMargin="99.0000" BottomMargin="69.0000" ctype="SpriteObjectData">
                    <Size X="26.0000" Y="26.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="93.9996" Y="82.0000" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition X="0.4845" Y="0.4227" />
                    <PreSize X="0.1340" Y="0.1340" />
                    <FileData Type="PlistSubImage" Path="fangkuai.png" Plist="ui/plist/common.plist" />
                    <BlendFunc Src="1" Dst="771" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="fangkuai_2" ActionTag="528984292" Tag="128" IconVisible="False" LeftMargin="107.9995" RightMargin="60.0005" TopMargin="99.0000" BottomMargin="69.0000" ctype="SpriteObjectData">
                    <Size X="26.0000" Y="26.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="120.9995" Y="82.0000" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition X="0.6237" Y="0.4227" />
                    <PreSize X="0.1340" Y="0.1340" />
                    <FileData Type="PlistSubImage" Path="fangkuai.png" Plist="ui/plist/common.plist" />
                    <BlendFunc Src="1" Dst="771" />
                  </AbstractNodeData>
                </Children>
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="254.0000" Y="480.0000" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.3969" Y="0.4225" />
                <PreSize X="0.3031" Y="0.1708" />
                <SingleColor A="255" R="150" G="200" B="255" />
                <FirstColor A="255" R="150" G="200" B="255" />
                <EndColor A="255" R="255" G="255" B="255" />
                <ColorVector ScaleY="1.0000" />
              </AbstractNodeData>
              <AbstractNodeData Name="big_gear" ActionTag="1384666103" Tag="99" RotationSkewX="312.0000" RotationSkewY="312.0000" IconVisible="False" LeftMargin="297.0000" RightMargin="149.0000" TopMargin="636.9962" BottomMargin="305.0038" ctype="SpriteObjectData">
                <Size X="194.0000" Y="194.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="394.0000" Y="402.0038" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.6156" Y="0.3539" />
                <PreSize X="0.3031" Y="0.1708" />
                <FileData Type="Normal" Path="ui/login/big_gear.png" Plist="" />
                <BlendFunc Src="1" Dst="771" />
              </AbstractNodeData>
              <AbstractNodeData Name="content" ActionTag="559214576" Tag="110" IconVisible="False" LeftMargin="297.0000" RightMargin="149.0000" TopMargin="637.0000" BottomMargin="305.0000" TouchEnable="True" ClipAble="False" BackColorAlpha="102" ColorAngle="90.0000" Scale9Width="1" Scale9Height="1" ctype="PanelObjectData">
                <Size X="194.0000" Y="194.0000" />
                <Children>
                  <AbstractNodeData Name="fangkuai" ActionTag="572217900" Tag="115" IconVisible="False" LeftMargin="71.0000" RightMargin="97.0000" TopMargin="72.0000" BottomMargin="96.0000" ctype="SpriteObjectData">
                    <Size X="26.0000" Y="26.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="84.0000" Y="109.0000" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition X="0.4330" Y="0.5619" />
                    <PreSize X="0.1340" Y="0.1340" />
                    <FileData Type="PlistSubImage" Path="fangkuai.png" Plist="ui/plist/common.plist" />
                    <BlendFunc Src="1" Dst="771" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="fangkuai_0" ActionTag="-380288794" Tag="116" IconVisible="False" LeftMargin="98.0000" RightMargin="70.0000" TopMargin="72.0000" BottomMargin="96.0000" ctype="SpriteObjectData">
                    <Size X="26.0000" Y="26.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="111.0000" Y="109.0000" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition X="0.5722" Y="0.5619" />
                    <PreSize X="0.1340" Y="0.1340" />
                    <FileData Type="PlistSubImage" Path="fangkuai.png" Plist="ui/plist/common.plist" />
                    <BlendFunc Src="1" Dst="771" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="fangkuai_1" ActionTag="-1847135846" Tag="117" IconVisible="False" LeftMargin="71.0000" RightMargin="97.0000" TopMargin="99.0000" BottomMargin="69.0000" ctype="SpriteObjectData">
                    <Size X="26.0000" Y="26.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="84.0000" Y="82.0000" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition X="0.4330" Y="0.4227" />
                    <PreSize X="0.1340" Y="0.1340" />
                    <FileData Type="PlistSubImage" Path="fangkuai.png" Plist="ui/plist/common.plist" />
                    <BlendFunc Src="1" Dst="771" />
                  </AbstractNodeData>
                  <AbstractNodeData Name="fangkuai_2" ActionTag="1100000136" Tag="118" IconVisible="False" LeftMargin="98.0000" RightMargin="70.0000" TopMargin="99.0000" BottomMargin="69.0000" ctype="SpriteObjectData">
                    <Size X="26.0000" Y="26.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="111.0000" Y="82.0000" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition X="0.5722" Y="0.4227" />
                    <PreSize X="0.1340" Y="0.1340" />
                    <FileData Type="PlistSubImage" Path="fangkuai.png" Plist="ui/plist/common.plist" />
                    <BlendFunc Src="1" Dst="771" />
                  </AbstractNodeData>
                </Children>
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="394.0000" Y="402.0000" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.6156" Y="0.3539" />
                <PreSize X="0.3031" Y="0.1708" />
                <SingleColor A="255" R="150" G="200" B="255" />
                <FirstColor A="255" R="150" G="200" B="255" />
                <EndColor A="255" R="255" G="255" B="255" />
                <ColorVector ScaleY="1.0000" />
              </AbstractNodeData>
              <AbstractNodeData Name="gamename_bg" ActionTag="-971795589" Tag="100" IconVisible="False" LeftMargin="25.0002" RightMargin="24.9998" TopMargin="165.9998" BottomMargin="610.0002" ctype="SpriteObjectData">
                <Size X="590.0000" Y="360.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="320.0002" Y="790.0002" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.5000" Y="0.6954" />
                <PreSize X="0.9219" Y="0.3169" />
                <FileData Type="Normal" Path="ui/login/gamename_bg.png" Plist="" />
                <BlendFunc Src="1" Dst="771" />
              </AbstractNodeData>
              <AbstractNodeData Name="btn_play" ActionTag="-1178541226" Tag="103" IconVisible="False" LeftMargin="174.0000" RightMargin="174.0000" TopMargin="805.9996" BottomMargin="244.0004" TouchEnable="True" FontSize="14" Scale9Enable="True" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="262" Scale9Height="64" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                <Size X="292.0000" Y="86.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="320.0000" Y="287.0004" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.5000" Y="0.2526" />
                <PreSize X="0.4563" Y="0.0757" />
                <TextColor A="255" R="65" G="65" B="70" />
                <DisabledFileData Type="PlistSubImage" Path="power_start.png" Plist="ui/plist/common.plist" />
                <PressedFileData Type="PlistSubImage" Path="power_start.png" Plist="ui/plist/common.plist" />
                <NormalFileData Type="PlistSubImage" Path="power_start.png" Plist="ui/plist/common.plist" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="110" G="110" B="110" />
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