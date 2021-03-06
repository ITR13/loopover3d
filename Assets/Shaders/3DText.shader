﻿Shader "Example/3D Font Shader" {
	Properties{
		_FontTex("Font Texture", 2D) = "white" {}
	    _Color("Text Color", Color) = (1,1,1,1)
	}
		SubShader
	{
		CGPROGRAM
		#pragma multi_compile_instancing
		sampler2D _FontTex;
		UNITY_INSTANCING_BUFFER_START(Props)
			UNITY_DEFINE_INSTANCED_PROP(half4, _Color)
			UNITY_INSTANCING_BUFFER_END(Props)
		#pragma surface surf SimpleLambert alphatest:_Cutoff        

	half4 LightingSimpleLambert(SurfaceOutput s, half3 lightDir, half atten) {
		half NdotL = dot(s.Normal, lightDir);
		half4 c;
		c.rgb = s.Albedo * _LightColor0.rgb * ((NdotL + 1) * atten);
		c.a = s.Alpha;
		return c;
	}

	struct Input
	{
		float2 uv_FontTex;
		half4 color : Color;
	};
	void surf(Input IN, inout SurfaceOutput o) {
		half alpha = tex2D(_FontTex, IN.uv_FontTex).a;
		o.Alpha = alpha;          
		o.Albedo = IN.color.rgb;
	}
	ENDCG
	}
		Fallback "Transparent/Cutout/Diffuse"
}