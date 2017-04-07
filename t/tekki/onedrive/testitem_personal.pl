# linebreaks and spaces added to JSON for better readability
(
  root => {
    json => decode_json(
      q|{
  "@odata.type" : "#microsoft.graph.driveItem",
  "createdBy" : {
    "application" : {
      "id" : "44048800"
    },
    "user" : {
      "displayName" : "Cubulon Switzerland",
      "id" : "4f37ddbbf21200a5"
    }
  },
  "createdDateTime" : "2015-10-05T14:47:58.2Z",
  "cTag" : "adDo0RjM3RERCQkYyMTIwMEE1ITEwMy42MzYyNTAwNzY4NTM5MDAwMDA",
  "eTag" : "aNEYzN0REQkJGMjEyMDBBNSExMDMuMA",
  "id" : "4F37DDBBF21200A5!103",
  "lastModifiedBy" : {
    "application" : {
      "id" : "44048800"
    },
    "user" : {
      "displayName" : "Cubulon Switzerland",
      "id" : "4f37ddbbf21200a5"
    }
  },
  "lastModifiedDateTime" : "2017-03-13T13:14:45.39Z",
  "name" : "root",
  "parentReference" : {
    "driveId" : "4f37ddbbf21200a5",
    "id" : "4F37DDBBF21200A5!0",
    "path" : "/drive/root:"
  },
  "size" : 267851257,
  "webUrl" : "https://onedrive.live.com/?cid=4f37ddbbf21200a5",
  "fileSystemInfo" : {
    "createdDateTime" : "2015-10-05T14:47:58.2Z",
    "lastModifiedDateTime" : "2015-10-05T14:47:58.2Z"
  },
  "folder" : {
    "childCount" : 0
  },
  "root" : {}
}|
    ),
    content => {
      id      => '4F37DDBBF21200A5!103',
      ctag    => 'adDo0RjM3RERCQkYyMTIwMEE1ITEwMy42MzYyNTAwNzY4NTM5MDAwMDA',
      deleted => 0,
      etag    => 'aNEYzN0REQkJGMjEyMDBBNSExMDMuMA',
      exists  => 0,
      exists_identical => 0,
      file             => 0,
      folder           => 1,
      full_path        => 'root',
      lastmodified     => '2015-10-05T14:47:58.2Z',
      modifiedby       => 'Cubulon Switzerland',
      name             => 'root',
      mtime            => '',
      package          => 0,
      parent_id        => '',
      parent_path      => '',
      quickxor         => '',
      remote           => 0,
      root             => 1,
      sha1             => '',
      size             => 267851257,
    },
  },
  folder1 => {
    json => decode_json(
      q|{
  "@odata.type" : "#microsoft.graph.driveItem",
  "createdBy" : {
    "application" : {
      "id" : "44048800"
    },
    "user" : {
      "displayName" : "Cubulon Switzerland",
      "id" : "4f37ddbbf21200a5"
    }
  },
  "createdDateTime" : "2015-10-05T14:47:58.863Z",
  "cTag" : "adDo0RjM3RERCQkYyMTIwMEE1ITEwNS42MzYyNTAwNzY4NTM5MDAwMDA",
  "eTag" : "aNEYzN0REQkJGMjEyMDBBNSExMDUuMQ",
  "id" : "4F37DDBBF21200A5!105",
  "lastModifiedBy" : {
    "application" : {
      "id" : "44048800"
    },
    "user" : {
      "displayName" : "Cubulon Switzerland",
      "id" : "4f37ddbbf21200a5"
    }
  },
  "lastModifiedDateTime" : "2017-03-13T13:14:45.39Z",
  "name" : "Dokumente",
  "parentReference" : {
    "driveId" : "4f37ddbbf21200a5",
    "id" : "4F37DDBBF21200A5!103",
    "name" : "root:",
    "path" : "/drive/root:"
  },
  "size" : 267851257,
  "webUrl" : "https://1drv.ms/f/s!AKUAEvK73TdPaQ",
  "fileSystemInfo" : {
    "createdDateTime" : "2015-10-05T14:47:58.863Z",
    "lastModifiedDateTime" : "2015-10-05T14:47:58.863Z"
  },
  "folder" : {
    "childCount" : 0
  },
  "shared" : {
    "owner" : {
      "user" : {
        "displayName" : "Cubulon Switzerland",
        "id" : "4f37ddbbf21200a5"
      }
    },
    "scope" : "users"
  },
  "specialFolder" : {
    "name" : "documents"
  }
}|
    ),
    content => {
      id      => '4F37DDBBF21200A5!105',
      ctag    => 'adDo0RjM3RERCQkYyMTIwMEE1ITEwNS42MzYyNTAwNzY4NTM5MDAwMDA',
      deleted => 0,
      etag    => 'aNEYzN0REQkJGMjEyMDBBNSExMDUuMQ',
      exists  => 0,
      exists_identical => 0,
      file             => 0,
      folder           => 1,
      full_path        => 'Dokumente',
      lastmodified     => '2015-10-05T14:47:58.863Z',
      modifiedby       => 'Cubulon Switzerland',
      name             => 'Dokumente',
      mtime            => '',
      package          => 0,
      parent_id        => '4F37DDBBF21200A5!103',
      parent_path      => '',
      quickxor         => '',
      remote           => 0,
      root             => 0,
      sha1             => '',
      size             => 267851257,
    }
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
      "id" : "187ffeb3a66c53"
    },
    "user" : {
      "displayName" : "Rolf St\u00f6ckli",
      "id" : "7a47b77d5182c99c"
    },
    "oneDriveSync" : {
      "@odata.type" : "#microsoft.graph.identity",
      "id" : "944aaedc-59ee-4f3e-a5f7-bc490d31526f"
    }
  },
  "createdDateTime" : "2015-11-18T10:24:42.76Z",
  "cTag" : "adDo0RjM3RERCQkYyMTIwMEE1ITQ2MC42MzYyNTAwNzY4NTM5MDAwMDA",
  "eTag" : "aNEYzN0REQkJGMjEyMDBBNSE0NjAuMA",
  "id" : "4F37DDBBF21200A5!460",
  "lastModifiedBy" : {
    "application" : {
      "id" : "480728c5"
    },
    "device" : {
      "id" : "187ffeb3a66c53"
    },
    "user" : {
      "displayName" : "Rolf St\u00f6ckli",
      "id" : "7a47b77d5182c99c"
    },
    "oneDriveSync" : {
      "@odata.type" : "#microsoft.graph.identity",
      "id" : "944aaedc-59ee-4f3e-a5f7-bc490d31526f"
    }
  },
  "lastModifiedDateTime" : "2017-03-13T13:14:45.39Z",
  "name" : "Vorlagen",
  "parentReference" : {
    "driveId" : "4f37ddbbf21200a5",
    "id" : "4F37DDBBF21200A5!105",
    "name" : "Dokumente",
    "path" : "/drive/root:/Dokumente"
  },
  "size" : 5479072,
  "webUrl" : "https://1drv.ms/f/s!AKUAEvK73TdPg0w",
  "fileSystemInfo" : {
    "createdDateTime" : "2015-11-18T10:24:24Z",
    "lastModifiedDateTime" : "2015-11-18T10:24:24Z"
  },
  "folder" : {
    "childCount" : 0
  }
}|
    ),
    content => {
      id      => '4F37DDBBF21200A5!460',
      ctag    => 'adDo0RjM3RERCQkYyMTIwMEE1ITQ2MC42MzYyNTAwNzY4NTM5MDAwMDA',
      deleted => 0,
      etag    => 'aNEYzN0REQkJGMjEyMDBBNSE0NjAuMA',
      exists  => 0,
      exists_identical => 0,
      file             => 0,
      folder           => 1,
      full_path        => 'Dokumente/Vorlagen',
      lastmodified     => '2015-11-18T10:24:24Z',
      modifiedby       => 'Rolf Stöckli',
      name             => 'Vorlagen',
      mtime            => '',
      package          => 0,
      parent_id        => '4F37DDBBF21200A5!105',
      parent_path      => 'Dokumente',
      quickxor         => '',
      remote           => 0,
      root             => 0,
      sha1             => '',
      size             => 5479072,

    },
  },
  package1 => {
    json => decode_json(
      q|{
  "@odata.type" : "#microsoft.graph.driveItem",
  "createdBy" : {
    "application" : {
      "id" : "440fa028"
    },
    "user" : {
      "displayName" : "Cubulon Switzerland",
      "id" : "4f37ddbbf21200a5"
    }
  },
  "createdDateTime" : "2015-11-17T13:57:25.657Z",
  "cTag" : "adDo0RjM3RERCQkYyMTIwMEE1ITQ1My42MzU4MzM2NTQ2NDk3MDAwMDA",
  "eTag" : "aNEYzN0REQkJGMjEyMDBBNSE0NTMuMA",
  "id" : "4F37DDBBF21200A5!453",
  "lastModifiedBy" : {
    "application" : {
      "id" : "440fa028"
    },
    "user" : {
      "displayName" : "Cubulon Switzerland",
      "id" : "4f37ddbbf21200a5"
    }
  },
  "lastModifiedDateTime" : "2015-11-17T13:57:44.97Z",
  "name" : "Notizbuch von Cubulon",
  "parentReference" : {
    "driveId" : "4f37ddbbf21200a5",
    "id" : "4F37DDBBF21200A5!105",
    "name" : "Dokumente",
    "path" : "/drive/root:/Dokumente"
  },
  "size" : 13653,
  "webUrl" : "https://1drv.ms/o/s!AKUAEvK73TdPg0U",
  "fileSystemInfo" : {
    "createdDateTime" : "2015-11-17T13:57:25.657Z",
    "lastModifiedDateTime" : "2015-11-17T13:57:25.657Z"
  },
  "package" : {
    "type" : "oneNote"
  }
}|
    ),
    content => {
      id      => '4F37DDBBF21200A5!453',
      ctag    => 'adDo0RjM3RERCQkYyMTIwMEE1ITQ1My42MzU4MzM2NTQ2NDk3MDAwMDA',
      deleted => 0,
      etag    => 'aNEYzN0REQkJGMjEyMDBBNSE0NTMuMA',
      exists  => 0,
      exists_identical => 0,
      file             => 0,
      folder           => 0,
      full_path        => 'Dokumente/Notizbuch von Cubulon',
      lastmodified     => '2015-11-17T13:57:25.657Z',
      modifiedby       => 'Cubulon Switzerland',
      name             => 'Notizbuch von Cubulon',
      mtime            => '',
      package          => 1,
      parent_id        => '4F37DDBBF21200A5!105',
      parent_path      => 'Dokumente',
      quickxor         => '',
      remote           => 0,
      root             => 0,
      sha1             => '',
      size             => 13653,
    },
  },
  file1 => {
    json => decode_json(
      q|{
  "@odata.type" : "#microsoft.graph.driveItem",
  "@microsoft.graph.downloadUrl" : "https://boyvia-sn3301.files.1drv.com/y3pEA1hE7BB9FtdTdEEkuIDYSxbD2uj1A7yjvj9-oDk6tiI1WszphwxMpCaVykvO7NcuFDia0zGPZmNpJyIHAdZ69t7W66p4E2sEmWvDrYrreRAMF1sNluWjTHOw0GwbJfgirNNTBfAn-ydP3KMyjYpW7bbX0-bcojDY1ja8GfTfgs",
  "createdBy" : {
    "user" : {
      "displayName" : "Cubulon Switzerland",
      "id" : "4f37ddbbf21200a5"
    }
  },
  "createdDateTime" : "2017-03-13T19:30:12.44Z",
  "cTag" : "aYzo0RjM3RERCQkYyMTIwMEE1ITMyMTIuMjU4",
  "eTag" : "aNEYzN0REQkJGMjEyMDBBNSEzMjEyLjI",
  "id" : "4F37DDBBF21200A5!3212",
  "lastModifiedBy" : {
    "user" : {
      "displayName" : "Cubulon Switzerland",
      "id" : "4f37ddbbf21200a5"
    }
  },
  "lastModifiedDateTime" : "2017-03-13T19:30:29.937Z",
  "name" : "Testdocument.txt",
  "parentReference" : {
    "driveId" : "4f37ddbbf21200a5",
    "id" : "4F37DDBBF21200A5!460",
    "name" : "Vorlagen",
    "path" : "/drive/root:/Dokumente/Vorlagen"
  },
  "size" : 18,
  "webUrl" : "https://1drv.ms/t/s!AKUAEvK73TdPmQw",
  "file" : {
    "hashes" : {
      "crc32Hash" : "342280C3",
      "sha1Hash" : "318EA4D4E88E241691AB8A911BD90F4BD361AE99"
    },
    "mimeType" : "text/plain"
  },
  "fileSystemInfo" : {
    "createdDateTime" : "2017-03-13T19:30:12.44Z",
    "lastModifiedDateTime" : "2017-03-13T19:30:29.913Z"
  }
}|
    ),
    content => {
      id               => '4F37DDBBF21200A5!3212',
      ctag             => 'aYzo0RjM3RERCQkYyMTIwMEE1ITMyMTIuMjU4',
      deleted          => 0,
      etag             => 'aNEYzN0REQkJGMjEyMDBBNSEzMjEyLjI',
      exists           => 0,
      exists_identical => 0,
      file             => 1,
      folder           => 0,
      full_path        => 'Dokumente/Vorlagen/Testdocument.txt',
      lastmodified     => '2017-03-13T19:30:29.913Z',
      modifiedby       => 'Cubulon Switzerland',
      name             => 'Testdocument.txt',
      package          => 0,
      parent_id        => '4F37DDBBF21200A5!460',
      parent_path      => 'Dokumente/Vorlagen',
      quickxor         => '',
      remote           => 0,
      root             => 0,
      sha1 => '318ea4d4e88e241691ab8a911bd90f4bd361ae99',  # Original content.\n
      size => 18,
    },
  },
  file1_updated => {
    json => decode_json(
      q|{
  "@odata.type" : "#microsoft.graph.driveItem",
  "@microsoft.graph.downloadUrl" : "https://boyvia-sn3301.files.1drv.com/y3pmTJnvlz1kK40Yxht8P550VUzl_ol6zdNIcSx3iW_ggojSE1kbhvSWm2rhLGsMpD0Kgz_LeIh8-byaIbjJwHkvkcae4KusqNOi-0JCMaLsXvz9ZSsuebPjTOAVn-LLXhFJL0Ia5aDpB4n1-XLOnL3UvfhDy5d3SCpfh6Hw4-kjvc",
  "createdBy" : {
    "user" : {
      "displayName" : "Cubulon Switzerland",
      "id" : "4f37ddbbf21200a5"
    }
  },
  "createdDateTime" : "2017-03-13T19:30:12.44Z",
  "cTag" : "aYzo0RjM3RERCQkYyMTIwMEE1ITMyMTIuMjU5",
  "eTag" : "aNEYzN0REQkJGMjEyMDBBNSEzMjEyLjQ",
  "id" : "4F37DDBBF21200A5!3212",
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
  "lastModifiedDateTime" : "2017-03-13T19:51:34.74Z",
  "name" : "Testdocument.txt",
  "parentReference" : {
    "driveId" : "4f37ddbbf21200a5",
    "id" : "4F37DDBBF21200A5!460",
    "name" : "Vorlagen",
    "path" : "/drive/root:/Dokumente/Vorlagen"
  },
  "size" : 17,
  "webUrl" : "https://1drv.ms/t/s!AKUAEvK73TdPmQw",
  "file" : {
    "hashes" : {
      "sha1Hash" : "2D373547F93B36B1C61CE249B418F0520AAD9B0F"
    },
    "mimeType" : "text/plain"
  },
  "fileSystemInfo" : {
    "createdDateTime" : "2017-03-13T19:30:38Z",
    "lastModifiedDateTime" : "2017-03-13T19:51:35Z"
  }
}|
    ),
    content => {
      id               => '4F37DDBBF21200A5!3212',
      ctag             => 'aYzo0RjM3RERCQkYyMTIwMEE1ITMyMTIuMjU5',
      deleted          => 0,
      etag             => 'aNEYzN0REQkJGMjEyMDBBNSEzMjEyLjQ',
      exists           => 0,
      exists_identical => 0,
      file             => 1,
      folder           => 0,
      full_path        => 'Dokumente/Vorlagen/Testdocument.txt',
      lastmodified     => '2017-03-13T19:51:35Z',
      modifiedby       => 'Rolf Stöckli',
      name             => 'Testdocument.txt',
      package          => 0,
      parent_id        => '4F37DDBBF21200A5!460',
      parent_path      => 'Dokumente/Vorlagen',
      quickxor         => '',
      remote           => 0,
      root             => 0,
      sha1 => '2d373547f93b36b1c61ce249b418f0520aad9b0f',   # Updated content.\n
      size => 17,
    },
  },
  file1_renamed => {
    json => decode_json(
      q|{
  "@odata.type" : "#microsoft.graph.driveItem",
  "@microsoft.graph.downloadUrl" : "https://boyvia-sn3301.files.1drv.com/y3pEQhJhNdSKAu98Mwb48WQ_5bccoCC8BGbIS-3igg6XKdFVLVXEeO0B-dJzqvikEC-h8frScG_OsgCLZmdsKfTbL-Hh76jXhGdbC1MM13kPF4oAWOd2Co2Psckkz4X750K0ASwRbSPFu1Vf8Wp3HUUosvNxYsHnVsxuxhvT0iDq8k",
  "createdBy" : {
    "user" : {
      "displayName" : "Cubulon Switzerland",
      "id" : "4f37ddbbf21200a5"
    }
  },
  "createdDateTime" : "2017-03-13T19:30:12.44Z",
  "cTag" : "aYzo0RjM3RERCQkYyMTIwMEE1ITMyMTIuMjU5",
  "eTag" : "aNEYzN0REQkJGMjEyMDBBNSEzMjEyLjU",
  "id" : "4F37DDBBF21200A5!3212",
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
  "lastModifiedDateTime" : "2017-03-14T08:07:21.25Z",
  "name" : "Testdocument Renamed.txt",
  "parentReference" : {
    "driveId" : "4f37ddbbf21200a5",
    "id" : "4F37DDBBF21200A5!460",
    "name" : "Vorlagen",
    "path" : "/drive/root:/Dokumente/Vorlagen"
  },
  "size" : 17,
  "webUrl" : "https://1drv.ms/t/s!AKUAEvK73TdPmQw",
  "file" : {
    "hashes" : {
      "sha1Hash" : "2D373547F93B36B1C61CE249B418F0520AAD9B0F"
    },
    "mimeType" : "text/plain"
  },
  "fileSystemInfo" : {
    "createdDateTime" : "1970-01-01T00:00:00Z",
    "lastModifiedDateTime" : "2017-03-13T19:51:35Z"
  }
}|
    ),
    content => {
      id               => '4F37DDBBF21200A5!3212',
      ctag             => 'aYzo0RjM3RERCQkYyMTIwMEE1ITMyMTIuMjU5',
      deleted          => 0,
      etag             => 'aNEYzN0REQkJGMjEyMDBBNSEzMjEyLjU',
      exists           => 0,
      exists_identical => 0,
      file             => 1,
      folder           => 0,
      full_path        => 'Dokumente/Vorlagen/Testdocument Renamed.txt',
      lastmodified     => '2017-03-13T19:51:35Z',
      modifiedby       => 'Rolf Stöckli',
      name             => 'Testdocument Renamed.txt',
      package          => 0,
      parent_id        => '4F37DDBBF21200A5!460',
      parent_path      => 'Dokumente/Vorlagen',
      quickxor         => '',
      remote           => 0,
      root             => 0,
      sha1             => '2d373547f93b36b1c61ce249b418f0520aad9b0f',
      size             => 17,
    },
  },
  file1_moved => {    # move after rename
    json => decode_json(
      q|{
  "@odata.type" : "#microsoft.graph.driveItem",
  "@microsoft.graph.downloadUrl" : "https://nv3qiq-sn3301.files.1drv.com/y3pcBtvbPtwqGEkQV-pfCtBrTrCcNltq4-6vYOyM0lLa0ggukU4uLboCJh6j3g9fN2MlJ2egAVy6vwNbMTOfy9ex08-X8rakXjtnIcp6OjT34_-SJtgUDFgrxNdHX5f5xLRNwdYw_bRbQWU0njcwm9sGtvIonv_MR2gyAAEXpmLrR0",
  "createdBy" : {
    "user" : {
      "displayName" : "Cubulon Switzerland",
      "id" : "4f37ddbbf21200a5"
    }
  },
  "createdDateTime" : "2017-03-13T19:30:12.44Z",
  "cTag" : "aYzo0RjM3RERCQkYyMTIwMEE1ITMyMTIuMjU5",
  "eTag" : "aNEYzN0REQkJGMjEyMDBBNSEzMjEyLjY",
  "id" : "4F37DDBBF21200A5!3212",
  "lastModifiedBy" : {
    "user" : {
      "displayName" : "Cubulon Switzerland",
      "id" : "4f37ddbbf21200a5"
    }
  },
  "lastModifiedDateTime" : "2017-03-14T08:38:00.26Z",
  "name" : "Testdocument Renamed.txt",
  "parentReference" : {
    "driveId" : "4f37ddbbf21200a5",
    "id" : "4F37DDBBF21200A5!105",
    "name" : "Dokumente",
    "path" : "/drive/root:/Dokumente"
  },
  "size" : 17,
  "webUrl" : "https://1drv.ms/t/s!AKUAEvK73TdPmQw",
  "file" : {
    "hashes" : {
      "sha1Hash" : "2D373547F93B36B1C61CE249B418F0520AAD9B0F"
    },
    "mimeType" : "text/plain"
  },
  "fileSystemInfo" : {
    "createdDateTime" : "1970-01-01T00:00:00Z",
    "lastModifiedDateTime" : "2017-03-14T08:38:00.26Z"
  }
}|
    ),
    content => {
      id               => '4F37DDBBF21200A5!3212',
      ctag             => 'aYzo0RjM3RERCQkYyMTIwMEE1ITMyMTIuMjU5',
      deleted          => 0,
      etag             => 'aNEYzN0REQkJGMjEyMDBBNSEzMjEyLjY',
      exists           => 0,
      exists_identical => 0,
      file             => 1,
      folder           => 0,
      full_path        => 'Dokumente/Testdocument Renamed.txt',
      lastmodified     => '2017-03-14T08:38:00.26Z',
      modifiedby       => 'Cubulon Switzerland',
      name             => 'Testdocument Renamed.txt',
      package          => 0,
      parent_id        => '4F37DDBBF21200A5!105',
      parent_path      => 'Dokumente',
      quickxor         => '',
      remote           => 0,
      root             => 0,
      sha1             => '2d373547f93b36b1c61ce249b418f0520aad9b0f',
      size             => 17,
    },
  },
  folder1_renamed => {
    json => decode_json(
      q|{
  "@odata.type" : "#microsoft.graph.driveItem",
  "createdBy" : {
    "application" : {
      "id" : "44048800"
    },
    "user" : {
      "displayName" : "Cubulon Switzerland",
      "id" : "4f37ddbbf21200a5"
    }
  },
  "createdDateTime" : "2015-10-05T14:47:58.863Z",
  "cTag" : "adDo0RjM3RERCQkYyMTIwMEE1ITEwNS42MzYyNTI1MjA4ODg2MzAwMDA",
  "eTag" : "aNEYzN0REQkJGMjEyMDBBNSExMDUuMg",
  "id" : "4F37DDBBF21200A5!105",
  "lastModifiedBy" : {
    "application" : {
      "id" : "44048800"
    },
    "user" : {
      "displayName" : "Cubulon Switzerland",
      "id" : "4f37ddbbf21200a5"
    }
  },
  "lastModifiedDateTime" : "2017-03-16T09:08:08.863Z",
  "name" : "Documents",
  "parentReference" : {
    "driveId" : "4f37ddbbf21200a5",
    "id" : "4F37DDBBF21200A5!103",
    "name" : "root:",
    "path" : "/drive/root:"
  },
  "size" : 271225621,
  "webUrl" : "https://1drv.ms/f/s!AKUAEvK73TdPaQ",
  "fileSystemInfo" : {
    "createdDateTime" : "2015-10-05T14:47:58.863Z",
    "lastModifiedDateTime" : "2017-03-16T09:08:08.863Z"
  },
  "folder" : {
    "childCount" : 0
  },
  "shared" : {
    "owner" : {
      "user" : {
        "displayName" : "Cubulon Switzerland",
        "id" : "4f37ddbbf21200a5"
      }
    },
    "scope" : "users"
  },
  "specialFolder" : {
    "name" : "documents"
  }
}|
    ),
    content => {
      id      => '4F37DDBBF21200A5!105',
      ctag    => 'adDo0RjM3RERCQkYyMTIwMEE1ITEwNS42MzYyNTI1MjA4ODg2MzAwMDA',
      deleted => 0,
      etag    => 'aNEYzN0REQkJGMjEyMDBBNSExMDUuMg',
      exists  => 0,
      exists_identical => 0,
      file             => 0,
      folder           => 1,
      full_path        => 'Documents',
      lastmodified     => '2017-03-16T09:08:08.863Z',
      modifiedby       => 'Cubulon Switzerland',
      name             => 'Documents',
      mtime            => '',
      package          => 0,
      parent_id        => '4F37DDBBF21200A5!103',
      parent_path      => '',
      quickxor         => '',
      remote           => 0,
      root             => 0,
      sha1             => '',
      size             => 271225621,
    }
  },
  file1_moved_again => {
    json => decode_json(
      q|{
  "@odata.type" : "#microsoft.graph.driveItem",
  "@microsoft.graph.downloadUrl" : "https://boyvia-sn3301.files.1drv.com/y3pejHUvYeEqwRCt72d9AsxTOh86-H3Y2QTEDIMAA_4HhLF6_ocUxLFcIHdf-LtPa842MHW16rw70IQs60prFltw2J_yVuzWMWN5p1v5TGYgBvEwQGpB14iH7KPFvT7WE-GVjOUYtM0rtpTjaQxG4RQ3-dDTeh4D5N2NY2BkweIbdU",
  "createdBy" : {
    "user" : {
      "displayName" : "Cubulon Switzerland",
      "id" : "4f37ddbbf21200a5"
    }
  },
  "createdDateTime" : "2017-03-13T19:30:12.44Z",
  "cTag" : "aYzo0RjM3RERCQkYyMTIwMEE1ITMyMTIuMjU5",
  "eTag" : "aNEYzN0REQkJGMjEyMDBBNSEzMjEyLjk",
  "id" : "4F37DDBBF21200A5!3212",
  "lastModifiedBy" : {
    "user" : {
      "displayName" : "Cubulon Switzerland",
      "id" : "4f37ddbbf21200a5"
    }
  },
  "lastModifiedDateTime" : "2017-03-16T09:20:47.313Z",
  "name" : "Testdocument Renamed.txt",
  "parentReference" : {
    "driveId" : "4f37ddbbf21200a5",
    "id" : "4F37DDBBF21200A5!460",
    "name" : "Vorlagen",
    "path" : "/drive/root:/Documents/Vorlagen"
  },
  "size" : 17,
  "webUrl" : "https://1drv.ms/t/s!AKUAEvK73TdPmQw",
  "file" : {
    "hashes" : {
      "sha1Hash" : "2D373547F93B36B1C61CE249B418F0520AAD9B0F"
    },
    "mimeType" : "text/plain"
  },
  "fileSystemInfo" : {
    "createdDateTime" : "1970-01-01T00:00:00Z",
    "lastModifiedDateTime" : "2017-03-16T09:20:47.313Z"
  }
}|
    ),
    content => {
      id               => '4F37DDBBF21200A5!3212',
      ctag             => 'aYzo0RjM3RERCQkYyMTIwMEE1ITMyMTIuMjU5',
      deleted          => 0,
      etag             => 'aNEYzN0REQkJGMjEyMDBBNSEzMjEyLjk',
      exists           => 0,
      exists_identical => 0,
      file             => 1,
      folder           => 0,
      full_path        => 'Documents/Vorlagen/Testdocument Renamed.txt',
      lastmodified     => '2017-03-16T09:20:47.313Z',
      modifiedby       => 'Cubulon Switzerland',
      name             => 'Testdocument Renamed.txt',
      package          => 0,
      parent_id        => '4F37DDBBF21200A5!460',
      parent_path      => 'Documents/Vorlagen',
      quickxor         => '',
      remote           => 0,
      root             => 0,
      sha1             => '2d373547f93b36b1c61ce249b418f0520aad9b0f',
      size             => 17,
    },
  },
  file1_deleted => {    # delete after rename and move
    json => decode_json(
      q|{
  "@odata.type" : "#microsoft.graph.driveItem",
  "eTag" : "aNEYzN0REQkJGMjEyMDBBNSEzMjEyLjEw",
  "id" : "4F37DDBBF21200A5!3212",
  "lastModifiedBy" : {
    "user" : {
      "displayName" : "Cubulon Switzerland",
      "id" : "4f37ddbbf21200a5"
    }
  },
  "lastModifiedDateTime" : "2017-03-16T16:59:57.66Z",
  "name" : "Testdocument Renamed.txt",
  "parentReference" : {
    "driveId" : "4f37ddbbf21200a5",
    "id" : "4F37DDBBF21200A5!460",
    "name" : "Vorlagen",
    "path" : "/drive/root:/Documents/Vorlagen"
  },
  "webUrl" : "https://1drv.ms/u/s!AKUAEvK73TdPmQw",
  "deleted" : {},
  "file" : {}
}|
    ),
    content => {
      id               => '4F37DDBBF21200A5!3212',
      ctag             => '',
      deleted          => 1,
      etag             => 'aNEYzN0REQkJGMjEyMDBBNSEzMjEyLjEw',
      exists           => 0,
      exists_identical => 0,
      file             => 1,
      folder           => 0,
      full_path        => 'Documents/Vorlagen/Testdocument Renamed.txt',
      lastmodified     => '2017-03-16T16:59:57.66Z',
      modifiedby       => 'Cubulon Switzerland',
      name             => 'Testdocument Renamed.txt',
      package          => 0,
      parent_id        => '4F37DDBBF21200A5!460',
      parent_path      => 'Documents/Vorlagen',
      quickxor         => '',
      remote           => 0,
      root             => 0,
      sha1             => '',
      size             => 0,
    },
  },
  remote_folder => {
    json => decode_json(
      q|{
  "@odata.type" : "#microsoft.graph.driveItem",
  "createdBy" : {
    "application" : {
      "id" : "44048800"
    },
    "user" : {
      "displayName" : "Cubulon Switzerland",
      "id" : "4f37ddbbf21200a5"
    }
  },
  "createdDateTime" : "2017-03-15T08:56:44.747Z",
  "cTag" : "adDo0RjM3RERCQkYyMTIwMEE1ITMyMzcuNjM2MjUxNjUwMDQ3NDcwMDAw",
  "eTag" : "aNEYzN0REQkJGMjEyMDBBNSEzMjM3LjA",
  "id" : "4F37DDBBF21200A5!3237",
  "lastModifiedBy" : {
    "application" : {
      "id" : "44048800"
    },
    "user" : {
      "displayName" : "Cubulon Switzerland",
      "id" : "4f37ddbbf21200a5"
    }
  },
  "lastModifiedDateTime" : "2017-03-15T08:56:44.747Z",
  "name" : "Shared with Cubulon",
  "parentReference" : {
    "driveId" : "4f37ddbbf21200a5",
    "id" : "4F37DDBBF21200A5!103",
    "name" : "root:",
    "path" : "/drive/root:"
  },
  "webUrl" : "https://1drv.ms/u/s!AJzJglF9t0d6io1b",
  "remoteItem" : {
    "fileSystemInfo" : {
      "createdDateTime" : "2017-03-15T08:48:44Z",
      "lastModifiedDateTime" : "2017-03-15T08:49:07Z"
    },
    "folder" : {
      "childCount" : 1
    },
    "id" : "7A47B77D5182C99C!165595",
    "parentReference" : {
      "driveId" : "7a47b77d5182c99c"
    },
    "size" : 38,
    "webUrl" : "https://1drv.ms/u/s!AJzJglF9t0d6io1b"
  }
}|
    ),
    content => {
      id      => '4F37DDBBF21200A5!3237',
      ctag    => 'adDo0RjM3RERCQkYyMTIwMEE1ITMyMzcuNjM2MjUxNjUwMDQ3NDcwMDAw',
      deleted => 0,
      etag    => 'aNEYzN0REQkJGMjEyMDBBNSEzMjM3LjA',
      exists  => 0,
      exists_identical => 0,
      file             => 0,
      folder           => 1,
      full_path        => 'Shared with Cubulon',
      lastmodified     => '2017-03-15T08:56:44.747Z',
      modifiedby       => 'Cubulon Switzerland',
      name             => 'Shared with Cubulon',
      mtime            => '',
      package          => 0,
      parent_id        => '4F37DDBBF21200A5!103',
      parent_path      => '',
      quickxor         => '',
      remote           => 1,
      root             => 0,
      sha1             => '',
      size             => 38,
    },
  },
);
