import 'package:cobed/Provider/OrgAuth.dart';
import 'package:cobed/Utils/Constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomFormField extends StatefulWidget{
  final String hintText;
  final double width;
  final Color cursorColor;
  final bool pass, number, map, multilinePost, titlePost, done;
  final Function function, valid;

  CustomFormField({@required this.hintText,@required this.width, this.done=true,
    @required this.cursorColor, @required this.number,@required this.function,
    @required this.valid,this.pass,this.map,this.multilinePost,this.titlePost});

  @override
  CustomFormFieldState createState() => CustomFormFieldState();
}

class CustomFormFieldState extends State<CustomFormField>{
  bool _obscure = false;
  Icon _icon = Icon(Icons.visibility,color: Constants.OrangeColor);

  _getType(){
    if(widget.pass)
      return TextInputType.visiblePassword;
    else if(widget.number)
      return TextInputType.number;
    else if(widget.multilinePost)
      return TextInputType.multiline;
    else
      return TextInputType.text;
  }

  _getSuffixIcon(){
    if(widget.map)
      return Icon(CupertinoIcons.search,color: Constants.OrangeColor);
    else if(widget.pass)
      return IconButton(icon: _icon, onPressed: (){
        setState(() {
          _obscure=!_obscure;
          if(!_obscure)
            _icon = Icon(Icons.visibility_off,color: Constants.OrangeColor);
          else
            _icon = Icon(Icons.visibility,color: Constants.OrangeColor);
        });
      });
    else
      SizedBox();
  }

  bool _abilityToReadOnly(){
    bool result = false;
    if(widget.map == false && widget.titlePost == false && widget.multilinePost == false)
      result = Provider.of<OrgAuth>(context,listen: false).loading;
    return result;
  }

  @override
  void initState() {
    super.initState();
    if(widget.pass)
      _obscure = true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width*0.9,
      margin: EdgeInsets.symmetric(horizontal: widget.width*0.05),
      padding: const EdgeInsets.only(left:5.0),
      decoration: BoxDecoration(
        color: Constants.WhiteColor,
        borderRadius: BorderRadius.circular(40.0),
      ),
      child: TextFormField(
        textAlign: TextAlign.center,
        keyboardType: _getType(),
        autofocus: false,
        decoration: InputDecoration(
          suffixIcon: _getSuffixIcon(),
          border: InputBorder.none,
          hintText: widget.hintText,
          hintStyle: TextStyle(
              fontSize: 18.0,
              color: Constants.GrayLightColor
          ),
        ),
        readOnly: _abilityToReadOnly(),
        obscureText: _obscure,
        style: TextStyle(
          fontSize: 20.0,
        ),
        cursorColor: widget.cursorColor,
        onChanged: (widget.multilinePost||widget.titlePost)?widget.function:(_){},
        validator: (widget.multilinePost||widget.titlePost)?(_)=>null:widget.valid,
        onFieldSubmitted: (widget.map)?widget.function:(_){},
        onSaved: (widget.map||widget.multilinePost||widget.titlePost)?(_){}:widget.function,
        textInputAction: (widget.done)?TextInputAction.done:TextInputAction.next,
      ),
    );
  }
}