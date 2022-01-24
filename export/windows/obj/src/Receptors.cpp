// Generated by Haxe 4.1.5
#include <hxcpp.h>

#ifndef INCLUDED_Receptors
#include <Receptors.h>
#endif
#ifndef INCLUDED_flixel_FlxBasic
#include <flixel/FlxBasic.h>
#endif
#ifndef INCLUDED_flixel_FlxObject
#include <flixel/FlxObject.h>
#endif
#ifndef INCLUDED_flixel_FlxSprite
#include <flixel/FlxSprite.h>
#endif
#ifndef INCLUDED_flixel_animation_FlxAnimation
#include <flixel/animation/FlxAnimation.h>
#endif
#ifndef INCLUDED_flixel_animation_FlxAnimationController
#include <flixel/animation/FlxAnimationController.h>
#endif
#ifndef INCLUDED_flixel_animation_FlxBaseAnimation
#include <flixel/animation/FlxBaseAnimation.h>
#endif
#ifndef INCLUDED_flixel_util_IFlxDestroyable
#include <flixel/util/IFlxDestroyable.h>
#endif

HX_DEFINE_STACK_FRAME(_hx_pos_652a5cf3df4139de_10_new,"Receptors","new",0x225ad589,"Receptors.new","Receptors.hx",10,0xac59ee07)
HX_LOCAL_STACK_FRAME(_hx_pos_652a5cf3df4139de_14_update,"Receptors","update",0x8c896080,"Receptors.update","Receptors.hx",14,0xac59ee07)

void Receptors_obj::__construct(){
            	HX_STACKFRAME(&_hx_pos_652a5cf3df4139de_10_new)
HXDLIN(  10)		super::__construct(null(),null(),null());
            	}

Dynamic Receptors_obj::__CreateEmpty() { return new Receptors_obj; }

void *Receptors_obj::_hx_vtable = 0;

Dynamic Receptors_obj::__Create(::hx::DynamicArray inArgs)
{
	::hx::ObjectPtr< Receptors_obj > _hx_result = new Receptors_obj();
	_hx_result->__construct();
	return _hx_result;
}

bool Receptors_obj::_hx_isInstanceOf(int inClassId) {
	if (inClassId<=(int)0x2c01639b) {
		if (inClassId<=(int)0x2638d257) {
			return inClassId==(int)0x00000001 || inClassId==(int)0x2638d257;
		} else {
			return inClassId==(int)0x2c01639b;
		}
	} else {
		return inClassId==(int)0x7ccf8994 || inClassId==(int)0x7dab0655;
	}
}

void Receptors_obj::update(Float elapsed){
            	HX_STACKFRAME(&_hx_pos_652a5cf3df4139de_14_update)
HXLINE(  15)		if ((this->animation->_curAnim->name == HX_("pressed",a2,d2,e6,39))) {
HXLINE(  16)			this->pressed = true;
            		}
            		else {
HXLINE(  18)			this->pressed = false;
            		}
HXLINE(  20)		this->super::update(elapsed);
            	}



::hx::ObjectPtr< Receptors_obj > Receptors_obj::__new() {
	::hx::ObjectPtr< Receptors_obj > __this = new Receptors_obj();
	__this->__construct();
	return __this;
}

::hx::ObjectPtr< Receptors_obj > Receptors_obj::__alloc(::hx::Ctx *_hx_ctx) {
	Receptors_obj *__this = (Receptors_obj*)(::hx::Ctx::alloc(_hx_ctx, sizeof(Receptors_obj), true, "Receptors"));
	*(void **)__this = Receptors_obj::_hx_vtable;
	__this->__construct();
	return __this;
}

Receptors_obj::Receptors_obj()
{
}

::hx::Val Receptors_obj::__Field(const ::String &inName,::hx::PropertyAccess inCallProp)
{
	switch(inName.length) {
	case 6:
		if (HX_FIELD_EQ(inName,"update") ) { return ::hx::Val( update_dyn() ); }
		break;
	case 7:
		if (HX_FIELD_EQ(inName,"pressed") ) { return ::hx::Val( pressed ); }
	}
	return super::__Field(inName,inCallProp);
}

::hx::Val Receptors_obj::__SetField(const ::String &inName,const ::hx::Val &inValue,::hx::PropertyAccess inCallProp)
{
	switch(inName.length) {
	case 7:
		if (HX_FIELD_EQ(inName,"pressed") ) { pressed=inValue.Cast< bool >(); return inValue; }
	}
	return super::__SetField(inName,inValue,inCallProp);
}

void Receptors_obj::__GetFields(Array< ::String> &outFields)
{
	outFields->push(HX_("pressed",a2,d2,e6,39));
	super::__GetFields(outFields);
};

#ifdef HXCPP_SCRIPTABLE
static ::hx::StorageInfo Receptors_obj_sMemberStorageInfo[] = {
	{::hx::fsBool,(int)offsetof(Receptors_obj,pressed),HX_("pressed",a2,d2,e6,39)},
	{ ::hx::fsUnknown, 0, null()}
};
static ::hx::StaticInfo *Receptors_obj_sStaticStorageInfo = 0;
#endif

static ::String Receptors_obj_sMemberFields[] = {
	HX_("pressed",a2,d2,e6,39),
	HX_("update",09,86,05,87),
	::String(null()) };

::hx::Class Receptors_obj::__mClass;

void Receptors_obj::__register()
{
	Receptors_obj _hx_dummy;
	Receptors_obj::_hx_vtable = *(void **)&_hx_dummy;
	::hx::Static(__mClass) = new ::hx::Class_obj();
	__mClass->mName = HX_("Receptors",17,5d,f5,62);
	__mClass->mSuper = &super::__SGetClass();
	__mClass->mConstructEmpty = &__CreateEmpty;
	__mClass->mConstructArgs = &__Create;
	__mClass->mGetStaticField = &::hx::Class_obj::GetNoStaticField;
	__mClass->mSetStaticField = &::hx::Class_obj::SetNoStaticField;
	__mClass->mStatics = ::hx::Class_obj::dupFunctions(0 /* sStaticFields */);
	__mClass->mMembers = ::hx::Class_obj::dupFunctions(Receptors_obj_sMemberFields);
	__mClass->mCanCast = ::hx::TCanCast< Receptors_obj >;
#ifdef HXCPP_SCRIPTABLE
	__mClass->mMemberStorageInfo = Receptors_obj_sMemberStorageInfo;
#endif
#ifdef HXCPP_SCRIPTABLE
	__mClass->mStaticStorageInfo = Receptors_obj_sStaticStorageInfo;
#endif
	::hx::_hx_RegisterClass(__mClass->mName, __mClass);
}

