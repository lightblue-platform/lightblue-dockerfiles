#!/bin/python
#
# Build a docker container using the given files in deployments/ dir
#
# By default, tags the image with lightblue:dev

import subprocess, sys, getopt, os, shutil


def printhelp():
    print("buildimage.py [-t tag] deploy-file [deploy-file...]")

def main(argv):

    tag='lightblue:dev'
    deploylist=[]
    
    try:
        optionlist,deploylist = getopt.getopt(argv,"t:")
    except getopt.GetoptError:
        printhelp()
        sys.exit(2)

    for opt,arg in optionlist:
        if opt == '-t':
            tag=arg
    if len(deploylist)==0:
        printhelp()
        sys.exit(0)

    ftemplate = open('Dockerfile.template','r')
    template = ftemplate.read()
    ftemplate.close()

    if os.path.exists('work'):
        shutil.rmtree('work')
    shutil.copytree('context.template/','work/',symlinks=False)
    for f in deploylist:
        shutil.copy(f,'work/')
        template+="ADD {0} $JBOSS_HOME/standalone/deployments/\n".format(os.path.basename(f))
    
    fdest = open('work/Dockerfile','w')
    fdest.write(template)
    fdest.close()
    args=["docker","build","work/"]
    if tag:
        args+=["-t",tag]
    subprocess.call(args)

if __name__ == "__main__":
    main(sys.argv[1:])
    
