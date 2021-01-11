#!/usr/bin/env python

import ConfigParser, sys, httplib, base64, json, os, subprocess

def clone_all(section, user, password, target):
    cred = base64.b64encode("%s:%s" % (user, password))
    https = httplib.HTTPSConnection("dev.azure.com")
    https.request("GET", "/%s/_apis/git/repositories?api-version=1.0" % (section), "", {
        "Accept": "application/json", 
        "Authorization": "Basic %s" % (cred)})
    resp = https.getresponse()
    if resp.status == 401:
        raise Exception("Authentication refused. Check your app password.")
    data = resp.read()
    parsed = json.loads(data)
    for repo in parsed["value"]:
        url = repo["sshUrl"]
        folder = target + repo["sshUrl"].replace("git@ssh.dev.azure.com:v3/%s" % (section), "")
        if os.path.exists(folder + "/.git"):
            print "PULL %s" % (folder)
            subprocess.call("cd %s && git pull" % (folder), shell=True)
        else:
            print "CLONE %s" % (folder) 
            os.makedirs(folder)
            subprocess.call("cd %s && cd .. && pwd && git clone %s" % (folder, url), shell=True)

def filename():
    if len(sys.argv) >= 2:
        return sys.argv[1]
    else:
        return sys.argv[0].replace(".py", ".ini")

if __name__ == "__main__":
    config = ConfigParser.ConfigParser()
    config.read(filename())
    for section in config.sections():
        user = config.get(section, "user")
        password = config.get(section, "pass")
        target = config.get(section, "target")
        clone_all(section, user, password, target)
    print "ok"
