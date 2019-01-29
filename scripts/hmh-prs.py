#! /usr/bin/env python

import json
import re
import requests
import sys

projectFolderDir = sys.argv[1] if sys.argv[1:] else u''
numPRsToGet = sys.argv[2] if sys.argv[2:] else u'20'
githubAuthToken = sys.argv[3] if sys.argv[3:] else u''

if not re.match(r"^[\S]*/[\S]+$", projectFolderDir) or projectFolderDir == u'':
  sys.exit('bad vars')

def getAllPRs():
  url = 'https://api.github.com/repos/{}/pulls'.format(projectFolderDir)
  params = { 'state': 'closed', 'per_page': numPRsToGet }
  headers = {
    'Authorization': '{}'.format(githubAuthToken)
  }

  r = requests.get(url, params=params, headers=headers)
  print url
  if(r.ok):
    repoItem = json.loads(r.text or r.content)
    return r.json()
  else:
    sys.exit('failed to get prs')

def getFormattedCommitMsg(originalMsg):
    semanticMsgNameRE = ur"(\w+)*:"
    replaceWithHighlight = "**\\1**:"
    if (re.match(semanticMsgNameRE, originalMsg)):
      return re.sub(
        semanticMsgNameRE,
        replaceWithHighlight,
        originalMsg,
        0,
        re.MULTILINE
      )
    else:
      return originalMsg


def getCommitHistory(commitURL):
  headers = {
    'Authorization': '{}'.format(githubAuthToken)
  }
  r = requests.get(commitURL, headers=headers)

  if(r.ok):
    return r.json()
  else:
    sys.exit('failed to load commit: {}'.format(commitURL))

prs = getAllPRs()
for pr in prs:
  print u'* {} [#{}]({})'.format(
    pr['title'],
    pr['number'],
    pr['html_url']
  )
  commits = getCommitHistory(pr['commits_url'])
  for c in commits:
    formattedMsg = getFormattedCommitMsg(c['commit']['message'].splitlines()[0])
    print u'  * [`{}`](https://github.com/hmhco/io.hmheng.planner-api/commit/{}) - {} '.format(
      c['sha'][0:7],
      c['sha'],
      formattedMsg,
    )

