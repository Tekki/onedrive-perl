# linebreaks and spaces added to JSON for better readability
(
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
      id      => '4F37DDBBF21200A5!3212',
      ctag    => 'aYzo0RjM3RERCQkYyMTIwMEE1ITMyMTIuMjU4',
      deleted => 0,
      download_url =>
        'https://boyvia-sn3301.files.1drv.com/y3pEA1hE7BB9FtdTdEEkuIDYSxbD2uj1A7yjvj9-oDk6tiI1WszphwxMpCaVykvO7NcuFDia0zGPZmNpJyIHAdZ69t7W66p4E2sEmWvDrYrreRAMF1sNluWjTHOw0GwbJfgirNNTBfAn-ydP3KMyjYpW7bbX0-bcojDY1ja8GfTfgs',
      etag             => 'aNEYzN0REQkJGMjEyMDBBNSEzMjEyLjI',
      exists           => 0,
      exists_identical => 0,
      file             => 1,
      folder           => 0,
      full_path        => 'Dokumente/Vorlagen/Testdocument.txt',
      lastmodified     => '2017-03-13T19:30:29.937Z',
      modifiedby       => 'Cubulon Switzerland',
      name             => 'Testdocument.txt',
      package          => 0,
      parent_id        => '4F37DDBBF21200A5!460',
      parent_path      => 'Dokumente/Vorlagen',
      root             => 0,
      sha1 => '318ea4d4e88e241691ab8a911bd90f4bd361ae99',  # Original content.\n
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
      id      => '4F37DDBBF21200A5!3212',
      ctag    => 'aYzo0RjM3RERCQkYyMTIwMEE1ITMyMTIuMjU5',
      deleted => 0,
      download_url =>
        'https://boyvia-sn3301.files.1drv.com/y3pmTJnvlz1kK40Yxht8P550VUzl_ol6zdNIcSx3iW_ggojSE1kbhvSWm2rhLGsMpD0Kgz_LeIh8-byaIbjJwHkvkcae4KusqNOi-0JCMaLsXvz9ZSsuebPjTOAVn-LLXhFJL0Ia5aDpB4n1-XLOnL3UvfhDy5d3SCpfh6Hw4-kjvc',
      etag             => 'aNEYzN0REQkJGMjEyMDBBNSEzMjEyLjQ',
      exists           => 0,
      exists_identical => 0,
      file             => 1,
      folder           => 0,
      full_path        => 'Dokumente/Vorlagen/Testdocument.txt',
      lastmodified     => '2017-03-13T19:51:34.74Z',
      modifiedby       => 'Rolf Stöckli',
      name             => 'Testdocument.txt',
      package          => 0,
      parent_id        => '4F37DDBBF21200A5!460',
      parent_path      => 'Dokumente/Vorlagen',
      root             => 0,
      sha1 => '2d373547f93b36b1c61ce249b418f0520aad9b0f',   # Updated content.\n
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
      id      => '4F37DDBBF21200A5!3212',
      ctag    => 'aYzo0RjM3RERCQkYyMTIwMEE1ITMyMTIuMjU5',
      deleted => 0,
      download_url =>
        'https://boyvia-sn3301.files.1drv.com/y3pEQhJhNdSKAu98Mwb48WQ_5bccoCC8BGbIS-3igg6XKdFVLVXEeO0B-dJzqvikEC-h8frScG_OsgCLZmdsKfTbL-Hh76jXhGdbC1MM13kPF4oAWOd2Co2Psckkz4X750K0ASwRbSPFu1Vf8Wp3HUUosvNxYsHnVsxuxhvT0iDq8k',
      etag             => 'aNEYzN0REQkJGMjEyMDBBNSEzMjEyLjU',
      exists           => 0,
      exists_identical => 0,
      file             => 1,
      folder           => 0,
      full_path        => 'Dokumente/Vorlagen/Testdocument Renamed.txt',
      lastmodified     => '2017-03-14T08:07:21.25Z',
      modifiedby       => 'Rolf Stöckli',
      name             => 'Testdocument Renamed.txt',
      package          => 0,
      parent_id        => '4F37DDBBF21200A5!460',
      parent_path      => 'Dokumente/Vorlagen',
      root             => 0,
      sha1             => '2d373547f93b36b1c61ce249b418f0520aad9b0f',
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
      id      => '4F37DDBBF21200A5!3212',
      ctag    => 'aYzo0RjM3RERCQkYyMTIwMEE1ITMyMTIuMjU5',
      deleted => 0,
      download_url =>
        'https://nv3qiq-sn3301.files.1drv.com/y3pcBtvbPtwqGEkQV-pfCtBrTrCcNltq4-6vYOyM0lLa0ggukU4uLboCJh6j3g9fN2MlJ2egAVy6vwNbMTOfy9ex08-X8rakXjtnIcp6OjT34_-SJtgUDFgrxNdHX5f5xLRNwdYw_bRbQWU0njcwm9sGtvIonv_MR2gyAAEXpmLrR0',
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
      root             => 0,
      sha1             => '2d373547f93b36b1c61ce249b418f0520aad9b0f',
    },
  },
  file1_deleted => {    # delete after rename and move
    json => decode_json(
      q|{
  "@odata.type" : "#microsoft.graph.driveItem",
  "eTag" : "aNEYzN0REQkJGMjEyMDBBNSEzMjEyLjc",
  "id" : "4F37DDBBF21200A5!3212",
  "lastModifiedBy" : {
    "user" : {
      "displayName" : "Cubulon Switzerland",
      "id" : "4f37ddbbf21200a5"
    }
  },
  "lastModifiedDateTime" : "2017-03-14T09:03:55.447Z",
  "name" : "Testdocument Renamed.txt",
  "parentReference" : {
    "driveId" : "4f37ddbbf21200a5",
    "id" : "4F37DDBBF21200A5!105",
    "name" : "Dokumente",
    "path" : "/drive/root:/Dokumente"
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
      download_url     => '',
      etag             => 'aNEYzN0REQkJGMjEyMDBBNSEzMjEyLjc',
      exists           => 0,
      exists_identical => 0,
      file             => 1,
      folder           => 0,
      full_path        => 'Dokumente/Testdocument Renamed.txt',
      lastmodified     => '2017-03-14T09:03:55.447Z',
      modifiedby       => 'Cubulon Switzerland',
      name             => 'Testdocument Renamed.txt',
      package          => 0,
      parent_id        => '4F37DDBBF21200A5!105',
      parent_path      => 'Dokumente',
      root             => 0,
      sha1             => '',
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
      id               => '4F37DDBBF21200A5!105',
      deleted          => 0,
      download_url     => '',
      etag             => 'aNEYzN0REQkJGMjEyMDBBNSExMDUuMQ',
      exists           => 0,
      exists_identical => 0,
      file             => 0,
      folder           => 1,
      full_path        => 'Dokumente',
      lastmodified     => '2017-03-13T13:14:45.39Z',
      modifiedby       => 'Cubulon Switzerland',
      name             => 'Dokumente',
      mtime            => '',
      package          => 0,
      parent_id        => '4F37DDBBF21200A5!103',
      parent_path      => '',
      root             => 0,
      sha1             => '',
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
      id               => '4F37DDBBF21200A5!460',
      deleted          => 0,
      download_url     => '',
      etag             => 'aNEYzN0REQkJGMjEyMDBBNSE0NjAuMA',
      exists           => 0,
      exists_identical => 0,
      file             => 0,
      folder           => 1,
      full_path        => 'Dokumente/Vorlagen',
      lastmodified     => '2017-03-13T13:14:45.39Z',
      modifiedby       => 'Rolf Stöckli',
      name             => 'Vorlagen',
      mtime            => '',
      package          => 0,
      parent_id        => '4F37DDBBF21200A5!105',
      parent_path      => 'Dokumente',
      root             => 0,
      sha1             => '',

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
      id               => '4F37DDBBF21200A5!453',
      deleted          => 0,
      download_url     => '',
      etag             => 'aNEYzN0REQkJGMjEyMDBBNSE0NTMuMA',
      exists           => 0,
      exists_identical => 0,
      file             => 0,
      folder           => 0,
      full_path        => 'Dokumente/Notizbuch von Cubulon',
      lastmodified     => '2015-11-17T13:57:44.97Z',
      modifiedby       => 'Cubulon Switzerland',
      name             => 'Notizbuch von Cubulon',
      mtime            => '',
      package          => 1,
      parent_id        => '4F37DDBBF21200A5!105',
      parent_path      => 'Dokumente',
      root             => 0,
      sha1             => '',
    },
  },
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
      id               => '4F37DDBBF21200A5!103',
      deleted          => 0,
      download_url     => '',
      etag             => 'aNEYzN0REQkJGMjEyMDBBNSExMDMuMA',
      exists           => 0,
      exists_identical => 0,
      file             => 0,
      folder           => 1,
      full_path        => 'root',
      lastmodified     => '2017-03-13T13:14:45.39Z',
      modifiedby       => 'Cubulon Switzerland',
      name             => 'root',
      mtime            => '',
      package          => 0,
      parent_id        => '',
      parent_path      => '',
      root             => 1,
      sha1             => '',
    },
  },
);
