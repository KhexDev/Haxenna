// Generated by Haxe 4.1.5
#ifndef INCLUDED_openfl_display__internal_DrawCommandType
#define INCLUDED_openfl_display__internal_DrawCommandType

#ifndef HXCPP_H
#include <hxcpp.h>
#endif

HX_DECLARE_CLASS3(openfl,display,_internal,DrawCommandType)
namespace openfl{
namespace display{
namespace _internal{


class DrawCommandType_obj : public ::hx::EnumBase_obj
{
	typedef ::hx::EnumBase_obj super;
		typedef DrawCommandType_obj OBJ_;

	public:
		DrawCommandType_obj() {};
		HX_DO_ENUM_RTTI;
		static void __boot();
		static void __register();
		static bool __GetStatic(const ::String &inName, Dynamic &outValue, ::hx::PropertyAccess inCallProp);
		::String GetEnumName( ) const { return HX_("openfl.display._internal.DrawCommandType",85,10,25,e2); }
		::String __ToString() const { return HX_("DrawCommandType.",2d,29,07,6b) + _hx_tag; }

		static ::openfl::display::_internal::DrawCommandType BEGIN_BITMAP_FILL;
		static inline ::openfl::display::_internal::DrawCommandType BEGIN_BITMAP_FILL_dyn() { return BEGIN_BITMAP_FILL; }
		static ::openfl::display::_internal::DrawCommandType BEGIN_FILL;
		static inline ::openfl::display::_internal::DrawCommandType BEGIN_FILL_dyn() { return BEGIN_FILL; }
		static ::openfl::display::_internal::DrawCommandType BEGIN_GRADIENT_FILL;
		static inline ::openfl::display::_internal::DrawCommandType BEGIN_GRADIENT_FILL_dyn() { return BEGIN_GRADIENT_FILL; }
		static ::openfl::display::_internal::DrawCommandType BEGIN_SHADER_FILL;
		static inline ::openfl::display::_internal::DrawCommandType BEGIN_SHADER_FILL_dyn() { return BEGIN_SHADER_FILL; }
		static ::openfl::display::_internal::DrawCommandType CUBIC_CURVE_TO;
		static inline ::openfl::display::_internal::DrawCommandType CUBIC_CURVE_TO_dyn() { return CUBIC_CURVE_TO; }
		static ::openfl::display::_internal::DrawCommandType CURVE_TO;
		static inline ::openfl::display::_internal::DrawCommandType CURVE_TO_dyn() { return CURVE_TO; }
		static ::openfl::display::_internal::DrawCommandType DRAW_CIRCLE;
		static inline ::openfl::display::_internal::DrawCommandType DRAW_CIRCLE_dyn() { return DRAW_CIRCLE; }
		static ::openfl::display::_internal::DrawCommandType DRAW_ELLIPSE;
		static inline ::openfl::display::_internal::DrawCommandType DRAW_ELLIPSE_dyn() { return DRAW_ELLIPSE; }
		static ::openfl::display::_internal::DrawCommandType DRAW_QUADS;
		static inline ::openfl::display::_internal::DrawCommandType DRAW_QUADS_dyn() { return DRAW_QUADS; }
		static ::openfl::display::_internal::DrawCommandType DRAW_RECT;
		static inline ::openfl::display::_internal::DrawCommandType DRAW_RECT_dyn() { return DRAW_RECT; }
		static ::openfl::display::_internal::DrawCommandType DRAW_ROUND_RECT;
		static inline ::openfl::display::_internal::DrawCommandType DRAW_ROUND_RECT_dyn() { return DRAW_ROUND_RECT; }
		static ::openfl::display::_internal::DrawCommandType DRAW_TILES;
		static inline ::openfl::display::_internal::DrawCommandType DRAW_TILES_dyn() { return DRAW_TILES; }
		static ::openfl::display::_internal::DrawCommandType DRAW_TRIANGLES;
		static inline ::openfl::display::_internal::DrawCommandType DRAW_TRIANGLES_dyn() { return DRAW_TRIANGLES; }
		static ::openfl::display::_internal::DrawCommandType END_FILL;
		static inline ::openfl::display::_internal::DrawCommandType END_FILL_dyn() { return END_FILL; }
		static ::openfl::display::_internal::DrawCommandType LINE_BITMAP_STYLE;
		static inline ::openfl::display::_internal::DrawCommandType LINE_BITMAP_STYLE_dyn() { return LINE_BITMAP_STYLE; }
		static ::openfl::display::_internal::DrawCommandType LINE_GRADIENT_STYLE;
		static inline ::openfl::display::_internal::DrawCommandType LINE_GRADIENT_STYLE_dyn() { return LINE_GRADIENT_STYLE; }
		static ::openfl::display::_internal::DrawCommandType LINE_STYLE;
		static inline ::openfl::display::_internal::DrawCommandType LINE_STYLE_dyn() { return LINE_STYLE; }
		static ::openfl::display::_internal::DrawCommandType LINE_TO;
		static inline ::openfl::display::_internal::DrawCommandType LINE_TO_dyn() { return LINE_TO; }
		static ::openfl::display::_internal::DrawCommandType MOVE_TO;
		static inline ::openfl::display::_internal::DrawCommandType MOVE_TO_dyn() { return MOVE_TO; }
		static ::openfl::display::_internal::DrawCommandType OVERRIDE_BLEND_MODE;
		static inline ::openfl::display::_internal::DrawCommandType OVERRIDE_BLEND_MODE_dyn() { return OVERRIDE_BLEND_MODE; }
		static ::openfl::display::_internal::DrawCommandType OVERRIDE_MATRIX;
		static inline ::openfl::display::_internal::DrawCommandType OVERRIDE_MATRIX_dyn() { return OVERRIDE_MATRIX; }
		static ::openfl::display::_internal::DrawCommandType UNKNOWN;
		static inline ::openfl::display::_internal::DrawCommandType UNKNOWN_dyn() { return UNKNOWN; }
		static ::openfl::display::_internal::DrawCommandType WINDING_EVEN_ODD;
		static inline ::openfl::display::_internal::DrawCommandType WINDING_EVEN_ODD_dyn() { return WINDING_EVEN_ODD; }
		static ::openfl::display::_internal::DrawCommandType WINDING_NON_ZERO;
		static inline ::openfl::display::_internal::DrawCommandType WINDING_NON_ZERO_dyn() { return WINDING_NON_ZERO; }
};

} // end namespace openfl
} // end namespace display
} // end namespace _internal

#endif /* INCLUDED_openfl_display__internal_DrawCommandType */ 
