@ECHO OFF

ECHO.&ECHO.Zoomla!����CMS V8(����.net Core)���ܰ�װ...
echo.��װǰ�����Ƿ�װ��IIS��.net core�йܳ���
echo.�Ƽ��Ҽ�����Ա�������,����̳����http://help.z01.com/v8
echo.
echo.��������ִ�����¼�����
echo.1-�����˿�Ϊ98��[ZoomlaCMS_V8]վ�㣬������ɾ���ؽ���
echo.2-������Զ��򿪰�װ�ɹ���վ�㣬���ܿ��ٲ����ʹ��Zoomla!����CMS
echo.���������ʼ&PAUSE >NUL 2>NUL

echo.
cd /d "%windir%\system32\inetsrv"

::���ɾ����վ��-�����
Appcmd.exe Delete site ZoomlaCMS_V8
Appcmd.exe Delete apppool ZoomlaCMS_V8

::������վ
Appcmd add site /name:"ZoomlaCMS_V8" /bindings:http://:98 /physicalpath:"c:\inetpub\wwwroot\zoomlacms\website"
Appcmd.exe Add AppPool /name:"ZoomlaCMS_V8"
Appcmd.exe Set app "ZoomlaCMS_V8/" /applicationpool:"ZoomlaCMS_V8"
Appcmd set apppool /apppool.name:ZoomlaCMS_V8 /enable32BitAppOnWin64:False
Appcmd set apppool /apppool.name:ZoomlaCMS_V8 /managedPipelineMode:Integrated

::����.net core���̳�Ϊ���й�
Appcmd set apppool /apppool.name:ZoomlaCMS_V8 /managedRuntimeVersion:""

::������վԤ����
Appcmd set apppool /apppool.name:ZoomlaCMS_V8 /startMode:AlwaysRunning 
Appcmd set site  ZoomlaCMS_V8 /applicationDefaults.preloadEnabled:true 

::����������վͼ��
mshta VBScript:Execute("Set a=CreateObject(""WScript.Shell""):Set b=a.CreateShortcut(a.SpecialFolders(""Desktop"") & ""\�ҵ���վ.lnk""):b.TargetPath=""http://localhost:98"":b.WorkingDirectory=""%~dp0"":b.Save:close")


ECHO.&ECHO.���������Web���棬���ֱ�ӹرգ�&PAUSE >NUL 2>NUL

start http://localhost:98
