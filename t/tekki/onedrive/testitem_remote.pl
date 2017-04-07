# linebreaks and spaces added to JSON for better readability
(
  folder1 => {
    json => decode_json(
      q|{
  "@odata.type" : "#microsoft.graph.driveItem",
  "createdBy" : {
    "application" : {
      "id" : "480728c5"
    },
    "device" : {
      "id" : "18000181dd0d9e"
    },
    "user" : {
      "displayName" : "Rolf St\u00f6ckli",
      "id" : "7a47b77d5182c99c"
    },
    "oneDriveSync" : {
      "@odata.type" : "#microsoft.graph.identity",
      "id" : "835efe71-0c45-4a50-b7a1-bfa5242e80dc"
    }
  },
  "createdDateTime" : "2017-03-15T08:48:52.373Z",
  "cTag" : "adDo3QTQ3Qjc3RDUxODJDOTlDITE2NTU5NS42MzYyNTE3MDk2MTIyMDAwMDA",
  "eTag" : "aN0E0N0I3N0Q1MTgyQzk5QyExNjU1OTUuMw",
  "id" : "7A47B77D5182C99C!165595",
  "lastModifiedBy" : {
    "user" : {
      "displayName" : "Rolf St\u00f6ckli",
      "id" : "7a47b77d5182c99c"
    }
  },
  "lastModifiedDateTime" : "2017-03-15T10:36:01.22Z",
  "name" : "Shared with Cubulon",
  "size" : 35,
  "webUrl" : "https://1drv.ms/f/s!AJzJglF9t0d6io1b",
  "fileSystemInfo" : {
    "createdDateTime" : "2017-03-15T08:48:44Z",
    "lastModifiedDateTime" : "2017-03-15T08:49:07Z"
  },
  "folder" : {
    "childCount" : 0
  },
  "shared" : {
    "owner" : {
      "user" : {
        "displayName" : "Rolf St\u00f6ckli",
        "id" : "7a47b77d5182c99c"
      }
    },
    "scope" : "users"
  }
}|
    ),
    content => {
      id      => '7A47B77D5182C99C!165595',
      ctag    => 'adDo3QTQ3Qjc3RDUxODJDOTlDITE2NTU5NS42MzYyNTE3MDk2MTIyMDAwMDA',
      deleted => 0,
      etag    => 'aN0E0N0I3N0Q1MTgyQzk5QyExNjU1OTUuMw',
      exists  => 0,
      exists_identical => 0,
      file             => 0,
      folder           => 1,
      full_path        => 'Shared with Cubulon',
      lastmodified     => '2017-03-15T08:49:07Z',
      modifiedby       => 'Rolf Stöckli',
      name             => 'Shared with Cubulon',
      mtime            => '',
      package          => 0,
      parent_id        => '',
      parent_path      => '',
      quickxor         => '',
      remote           => 0,
      root             => 1,
      sha1             => '',
      size             => 35,
    },
  },
  file1 => {
    json => decode_json(
      q|{
  "@odata.type" : "#microsoft.graph.driveItem",
  "@microsoft.graph.downloadUrl" : "https://1g9z7g-dm2306.files.1drv.com/y3pMtbcR4OWR7sZi_WbfbJzv37DNo8c5uQ2KtUwm5oHoOyrJ6MyHhyR9-ogO_qN0KkytOafieggph3xHSDsMzrYsaQ5mbgBxUBoDrL0NQ9NadW5ToSVnBhYRVPz9EL6Hi4QFucLwmlxFjNtGEEpHJbEXCVX1EK2rQXHK_yOfGfvvAuLMgV4Pzbw0cEwVmcdm7Aj",
  "createdBy" : {
    "application" : {
      "id" : "480728c5"
    },
    "device" : {
      "id" : "18000181dd0d9e"
    },
    "user" : {
      "displayName" : "Rolf St\u00f6ckli",
      "id" : "7a47b77d5182c99c"
    },
    "oneDriveSync" : {
      "@odata.type" : "#microsoft.graph.identity",
      "id" : "835efe71-0c45-4a50-b7a1-bfa5242e80dc"
    }
  },
  "createdDateTime" : "2017-03-15T08:49:11.593Z",
  "cTag" : "aYzo3QTQ3Qjc3RDUxODJDOTlDITE2NTU5Ni4yNTk",
  "eTag" : "aN0E0N0I3N0Q1MTgyQzk5QyExNjU1OTYuNQ",
  "id" : "7A47B77D5182C99C!165596",
  "lastModifiedBy" : {
    "application" : {
      "id" : "480728c5"
    },
    "device" : {
      "id" : "18000181dd0d9e"
    },
    "user" : {
      "displayName" : "Rolf St\u00f6ckli",
      "id" : "7a47b77d5182c99c"
    },
    "oneDriveSync" : {
      "@odata.type" : "#microsoft.graph.identity",
      "id" : "835efe71-0c45-4a50-b7a1-bfa5242e80dc"
    }
  },
  "lastModifiedDateTime" : "2017-03-15T10:36:01.22Z",
  "name" : "Document for Cubulon.txt",
  "parentReference" : {
    "driveId" : "7a47b77d5182c99c",
    "id" : "7A47B77D5182C99C!165595",
    "name" : "Shared with Cubulon",
    "path" : "/drives/7a47b77d5182c99c/items/7A47B77D5182C99C!165595:"
  },
  "size" : 35,
  "webUrl" : "https://1drv.ms/t/s!AJzJglF9t0d6io1c",
  "file" : {
    "hashes" : {
      "sha1Hash" : "E0748184024B0E27EAB166C096A6ED27F750D8D2"
    },
    "mimeType" : "text/plain"
  },
  "fileSystemInfo" : {
    "createdDateTime" : "2017-03-15T08:49:07Z",
    "lastModifiedDateTime" : "2017-03-15T10:36:01Z"
  }
}|
    ),
    content => {
      id               => '7A47B77D5182C99C!165596',
      ctag             => 'aYzo3QTQ3Qjc3RDUxODJDOTlDITE2NTU5Ni4yNTk',
      deleted          => 0,
      etag             => 'aN0E0N0I3N0Q1MTgyQzk5QyExNjU1OTYuNQ',
      exists           => 0,
      exists_identical => 0,
      file             => 1,
      folder           => 0,
      full_path        => 'Document for Cubulon.txt',
      lastmodified     => '2017-03-15T10:36:01Z',
      modifiedby       => 'Rolf Stöckli',
      name             => 'Document for Cubulon.txt',
      mtime            => '',
      package          => 0,
      parent_id        => '7A47B77D5182C99C!165595',
      parent_path      => '',
      quickxor         => '',
      remote           => 0,
      root             => 0,
      sha1             => 'e0748184024b0e27eab166c096a6ed27f750d8d2',
      size             => 35,
    },
  },
  folder2 => {
    json => decode_json(
      q|{
  "@odata.type" : "#microsoft.graph.driveItem",
  "createdBy" : {
    "application" : {
      "id" : "480728c5"
    },
    "device" : {
      "id" : "18000181dd0d9e"
    },
    "user" : {
      "displayName" : "Rolf St\u00f6ckli",
      "id" : "7a47b77d5182c99c"
    },
    "oneDriveSync" : {
      "@odata.type" : "#microsoft.graph.identity",
      "id" : "835efe71-0c45-4a50-b7a1-bfa5242e80dc"
    }
  },
  "createdDateTime" : "2017-03-21T17:06:42.84Z",
  "cTag" : "adDo3QTQ3Qjc3RDUxODJDOTlDITE2NTY0Mi42MzYyNTcxMjgzMTYyNzAwMDA",
  "eTag" : "aN0E0N0I3N0Q1MTgyQzk5QyExNjU2NDIuMA",
  "id" : "7A47B77D5182C99C!165642",
  "lastModifiedBy" : {
    "application" : {
      "id" : "480728c5"
    },
    "device" : {
      "id" : "18000181dd0d9e"
    },
    "user" : {
      "displayName" : "Rolf St\u00f6ckli",
      "id" : "7a47b77d5182c99c"
    },
    "oneDriveSync" : {
      "@odata.type" : "#microsoft.graph.identity",
      "id" : "835efe71-0c45-4a50-b7a1-bfa5242e80dc"
    }
  },
  "lastModifiedDateTime" : "2017-03-21T17:07:11.627Z",
  "name" : "Our new project",
  "parentReference" : {
    "driveId" : "7a47b77d5182c99c",
    "id" : "7A47B77D5182C99C!165595",
    "name" : "Shared with Cubulon",
    "path" : "/drives/7a47b77d5182c99c/items/7A47B77D5182C99C!165595:"
  },
  "size" : 41,
  "webUrl" : "https://1drv.ms/f/s!AJzJglF9t0d6io4K",
  "fileSystemInfo" : {
    "createdDateTime" : "2017-03-21T17:06:28Z",
    "lastModifiedDateTime" : "2017-03-21T17:06:28Z"
  },
  "folder" : {
    "childCount" : 0
  }
}|
    ),
    content => {
      id      => '7A47B77D5182C99C!165642',
      ctag    => 'adDo3QTQ3Qjc3RDUxODJDOTlDITE2NTY0Mi42MzYyNTcxMjgzMTYyNzAwMDA',
      deleted => 0,
      etag    => 'aN0E0N0I3N0Q1MTgyQzk5QyExNjU2NDIuMA',
      exists  => 0,
      exists_identical => 0,
      file             => 0,
      folder           => 1,
      full_path        => 'Our new project',
      lastmodified     => '2017-03-21T17:06:28Z',
      modifiedby       => 'Rolf Stöckli',
      name             => 'Our new project',
      mtime            => '',
      package          => 0,
      parent_id        => '7A47B77D5182C99C!165595',
      parent_path      => '',
      quickxor         => '',
      remote           => 0,
      root             => 0,
      sha1             => '',
      size             => 41,
    },
  },
  file2 => {
    json => decode_json(
      q|{
  "@odata.type" : "#microsoft.graph.driveItem",
  "@microsoft.graph.downloadUrl" : "https://1g9z7g-dm2306.files.1drv.com/y3pXLV6sfHv6k-epGUZjjxE6MPFgzKSXJrM1TLpHHhkbl6CiyUjEc_eBDilXcSUuRSBuzLUMTI5RbJQ_cbXFQrA-6WUvnAwFQPNngh78eTbPdZzpQcLI6xom9aLaDnF1mII7ZshPdLx1itmJ_3u_n9zTUlzCztVmKFx3Ln_8qIb0S4c_u6GlCQkJmvPSIYiT0z0",
  "createdBy" : {
    "application" : {
      "id" : "480728c5"
    },
    "device" : {
      "id" : "18000181dd0d9e"
    },
    "user" : {
      "displayName" : "Rolf St\u00f6ckli",
      "id" : "7a47b77d5182c99c"
    },
    "oneDriveSync" : {
      "@odata.type" : "#microsoft.graph.identity",
      "id" : "835efe71-0c45-4a50-b7a1-bfa5242e80dc"
    }
  },
  "createdDateTime" : "2017-03-21T17:06:48.217Z",
  "cTag" : "aYzo3QTQ3Qjc3RDUxODJDOTlDITE2NTY0My4yNTg",
  "eTag" : "aN0E0N0I3N0Q1MTgyQzk5QyExNjU2NDMuMw",
  "id" : "7A47B77D5182C99C!165643",
  "lastModifiedBy" : {
    "application" : {
      "id" : "480728c5"
    },
    "device" : {
      "id" : "18000181dd0d9e"
    },
    "user" : {
      "displayName" : "Rolf St\u00f6ckli",
      "id" : "7a47b77d5182c99c"
    },
    "oneDriveSync" : {
      "@odata.type" : "#microsoft.graph.identity",
      "id" : "835efe71-0c45-4a50-b7a1-bfa5242e80dc"
    }
  },
  "lastModifiedDateTime" : "2017-03-21T17:07:11.627Z",
  "name" : "Project description.txt",
  "parentReference" : {
    "driveId" : "7a47b77d5182c99c",
    "id" : "7A47B77D5182C99C!165642",
    "name" : "Our new project",
    "path" : "/drives/7a47b77d5182c99c/items/7A47B77D5182C99C!165595:/Our%20new%20project"
  },
  "size" : 41,
  "webUrl" : "https://1drv.ms/t/s!AJzJglF9t0d6io4L",
  "file" : {
    "hashes" : {
      "sha1Hash" : "6B67A4604A00FF88CB96635140BEE77BB1B3EA85"
    },
    "mimeType" : "text/plain"
  },
  "fileSystemInfo" : {
    "createdDateTime" : "2017-03-21T17:06:50Z",
    "lastModifiedDateTime" : "2017-03-21T17:07:12Z"
  }
}|
    ),
    content => {
      id               => '7A47B77D5182C99C!165643',
      ctag             => 'aYzo3QTQ3Qjc3RDUxODJDOTlDITE2NTY0My4yNTg',
      deleted          => 0,
      etag             => 'aN0E0N0I3N0Q1MTgyQzk5QyExNjU2NDMuMw',
      exists           => 0,
      exists_identical => 0,
      file             => 1,
      folder           => 0,
      full_path        => 'Our new project/Project description.txt',
      lastmodified     => '2017-03-21T17:07:12Z',
      modifiedby       => 'Rolf Stöckli',
      name             => 'Project description.txt',
      mtime            => '',
      package          => 0,
      parent_id        => '7A47B77D5182C99C!165642',
      parent_path      => 'Our new project',
      quickxor         => '',
      remote           => 0,
      root             => 0,
      sha1             => '6b67a4604a00ff88cb96635140bee77bb1b3ea85',
      size             => 41,
    },
  },
  folder3 => {
    json => decode_json(
      q|{
  "@odata.type" : "#microsoft.graph.driveItem",
  "createdBy" : {
    "application" : {
      "id" : "480728c5"
    },
    "device" : {
      "id" : "18000181dd0d9e"
    },
    "user" : {
      "displayName" : "Rolf St\u00f6ckli",
      "id" : "7a47b77d5182c99c"
    },
    "oneDriveSync" : {
      "@odata.type" : "#microsoft.graph.identity",
      "id" : "835efe71-0c45-4a50-b7a1-bfa5242e80dc"
    }
  },
  "createdDateTime" : "2017-03-23T08:53:05.067Z",
  "cTag" : "adDo3QTQ3Qjc3RDUxODJDOTlDITE2NTY1My42MzYyNTg1NjI1OTkyNzAwMDA",
  "eTag" : "aN0E0N0I3N0Q1MTgyQzk5QyExNjU2NTMuMQ",
  "id" : "7A47B77D5182C99C!165653",
  "lastModifiedBy" : {
    "application" : {
      "id" : "480728c5"
    },
    "device" : {
      "id" : "18000181dd0d9e"
    },
    "user" : {
      "displayName" : "Rolf St\u00f6ckli",
      "id" : "7a47b77d5182c99c"
    },
    "oneDriveSync" : {
      "@odata.type" : "#microsoft.graph.identity",
      "id" : "835efe71-0c45-4a50-b7a1-bfa5242e80dc"
    }
  },
  "lastModifiedDateTime" : "2017-03-23T08:57:39.927Z",
  "name" : "\u0420\u043e\u0441\u0441\u0438\u0439\u0441\u043a\u0430\u044f \u0433\u043e\u0441\u0443\u0434\u0430\u0440\u0441\u0442\u0432\u0435\u043d\u043d\u0430\u044f \u0431\u0438\u0431\u043b\u0438\u043e\u0442\u0435\u043a\u0430",
  "parentReference" : {
    "driveId" : "7a47b77d5182c99c",
    "id" : "7A47B77D5182C99C!165595",
    "name" : "Shared with Cubulon",
    "path" : "/drives/7a47b77d5182c99c/items/7A47B77D5182C99C!165595:"
  },
  "size" : 540,
  "webUrl" : "https://1drv.ms/f/s!AJzJglF9t0d6io4V",
  "fileSystemInfo" : {
    "createdDateTime" : "2017-03-23T08:52:56Z",
    "lastModifiedDateTime" : "2017-03-23T08:53:08Z"
  },
  "folder" : {
    "childCount" : 0
  }
}|
    ),
    content => {
      id      => '7A47B77D5182C99C!165653',
      ctag    => 'adDo3QTQ3Qjc3RDUxODJDOTlDITE2NTY1My42MzYyNTg1NjI1OTkyNzAwMDA',
      deleted => 0,
      etag    => 'aN0E0N0I3N0Q1MTgyQzk5QyExNjU2NTMuMQ',
      exists  => 0,
      exists_identical => 0,
      file             => 0,
      folder           => 1,
      full_path =>
        'Российская государственная библиотека',
      lastmodified => '2017-03-23T08:53:08Z',
      modifiedby   => 'Rolf Stöckli',
      name =>
        'Российская государственная библиотека',
      mtime       => '',
      package     => 0,
      parent_id   => '7A47B77D5182C99C!165595',
      parent_path => '',
      quickxor    => '',
      remote      => 0,
      root        => 0,
      sha1        => '',
      size        => 540,
    },
  },

  file3 => {
    json => decode_json(
      q|{
  "@odata.type" : "#microsoft.graph.driveItem",
  "@microsoft.graph.downloadUrl" : "https://1g9z7g-dm2306.files.1drv.com/y3pivLwuDL80ZYTmM3FBtlH0iNqSCd3r2dRlU-nEhnJOJ9mGENwVxqtGu5pXdn1KN7U7tNqbs3gO_z8Bzn42u-dieZ80U1szZgfI4EP1gGxUu_VnU4dU_6tY4dCyqjAQ97CfaZX7s1cuzTpdKDuons0z1rS4HDhsjl1sQjidTFUqQKr_eog1Oq6m0L8uoRATmZJ",
  "createdBy" : {
    "application" : {
      "id" : "480728c5"
    },
    "device" : {
      "id" : "18000181dd0d9e"
    },
    "user" : {
      "displayName" : "Rolf St\u00f6ckli",
      "id" : "7a47b77d5182c99c"
    },
    "oneDriveSync" : {
      "@odata.type" : "#microsoft.graph.identity",
      "id" : "835efe71-0c45-4a50-b7a1-bfa5242e80dc"
    }
  },
  "createdDateTime" : "2017-03-23T08:53:14.86Z",
  "cTag" : "aYzo3QTQ3Qjc3RDUxODJDOTlDITE2NTY1NC4yNTg",
  "eTag" : "aN0E0N0I3N0Q1MTgyQzk5QyExNjU2NTQuMw",
  "id" : "7A47B77D5182C99C!165654",
  "lastModifiedBy" : {
    "application" : {
      "id" : "480728c5"
    },
    "device" : {
      "id" : "18000181dd0d9e"
    },
    "user" : {
      "displayName" : "Rolf St\u00f6ckli",
      "id" : "7a47b77d5182c99c"
    },
    "oneDriveSync" : {
      "@odata.type" : "#microsoft.graph.identity",
      "id" : "835efe71-0c45-4a50-b7a1-bfa5242e80dc"
    }
  },
  "lastModifiedDateTime" : "2017-03-23T08:57:39.927Z",
  "name" : "\u041d\u043e\u0432\u043e\u0441\u0442\u0438.txt",
  "parentReference" : {
    "driveId" : "7a47b77d5182c99c",
    "id" : "7A47B77D5182C99C!165653",
    "name" : "\u0420\u043e\u0441\u0441\u0438\u0439\u0441\u043a\u0430\u044f \u0433\u043e\u0441\u0443\u0434\u0430\u0440\u0441\u0442\u0432\u0435\u043d\u043d\u0430\u044f \u0431\u0438\u0431\u043b\u0438\u043e\u0442\u0435\u043a\u0430",
    "path" : "/drives/7a47b77d5182c99c/items/7A47B77D5182C99C!165595:/%D0%A0%D0%BE%D1%81%D1%81%D0%B8%D0%B9%D1%81%D0%BA%D0%B0%D1%8F%20%D0%B3%D0%BE%D1%81%D1%83%D0%B4%D0%B0%D1%80%D1%81%D1%82%D0%B2%D0%B5%D0%BD%D0%BD%D0%B0%D1%8F%20%D0%B1%D0%B8%D0%B1%D0%BB%D0%B8%D0%BE%D1%82%D0%B5%D0%BA%D0%B0"
  },
  "size" : 540,
  "webUrl" : "https://1drv.ms/t/s!AJzJglF9t0d6io4W",
  "file" : {
    "hashes" : {
      "sha1Hash" : "F6E9EEB9AF690BA110AFF1093A8F4055D6E8F460"
    },
    "mimeType" : "text/plain"
  },
  "fileSystemInfo" : {
    "createdDateTime" : "2017-03-23T08:53:08Z",
    "lastModifiedDateTime" : "2017-03-23T08:57:40Z"
  }
}|
    ),
    content => {
      id               => '7A47B77D5182C99C!165654',
      ctag             => 'aYzo3QTQ3Qjc3RDUxODJDOTlDITE2NTY1NC4yNTg',
      deleted          => 0,
      etag             => 'aN0E0N0I3N0Q1MTgyQzk5QyExNjU2NTQuMw',
      exists           => 0,
      exists_identical => 0,
      file             => 1,
      folder           => 0,
      full_path =>
        'Российская государственная библиотека/Новости.txt',
      lastmodified => '2017-03-23T08:57:40Z',
      modifiedby   => 'Rolf Stöckli',
      name         => 'Новости.txt',
      mtime        => '',
      package      => 0,
      parent_id    => '7A47B77D5182C99C!165653',
      parent_path =>
        'Российская государственная библиотека',
      quickxor => '',
      remote   => 0,
      root     => 0,
      sha1     => 'f6e9eeb9af690ba110aff1093a8f4055d6e8f460',
      size     => 540,
    },
  },
);
